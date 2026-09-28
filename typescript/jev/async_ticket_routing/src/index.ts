// index.ts: Asynchronous Jev support-ticket routing on Cloudflare Workers
//
// Description:
// Worker entry point for a sample that accepts support tickets over HTTP,
// stores them in D1, and routes them asynchronously through Cloudflare
// Queues. The Queue consumer evaluates each ticket with typesafe/jev through
// Workers AI, applies deterministic routing rules, and records retry, Dead
// Letter Queue, and final states in D1. See README.md in this sample for the
// routing rules, states, and setup details.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm install
//     npm run types
//     npx wrangler d1 execute jev-ticket-routing --local \
//       --file=./migrations/0001_create_tickets.sql
//     npx wrangler dev
//
//     npm run typecheck
//
// Requirements:
// - Node.js 22 or later and npm
// - TypeScript 7.0.2 or later
// - Wrangler 4.135.0 or later
// - A Cloudflare account with access to Workers AI, Queues, and D1, with
//   Wrangler authenticated against it
//
// Notes:
// - The AI binding is remote, so requests that reach Jev use the Cloudflare
//   account configured for Wrangler and may consume Workers AI usage.
// - Creating the Queues and the D1 database, and setting the D1 database ID
//   in wrangler.jsonc, are described in README.md. Account-specific resource
//   identifiers are not committed.

type TicketMessage = {
  ticketId: string;
};

type TicketStatus =
  | "queued"
  | "enqueue_failed"
  | "processing"
  | "retrying"
  | "processed"
  | "human-review"
  | "dead-letter";

type Department = "account" | "billing" | "technical" | "other";

type TicketRow = {
  id: string;
  body: string;
  status: TicketStatus;
  attempts: number;
};

type JevResult = {
  model: string;
  answers: {
    department: {
      type: "choice";
      choice: Department;
      confidence: number;
      probabilities: Record<string, number>;
    };
    manual_review: {
      type: "noul";
      noul: number;
    };
    urgency: {
      type: "score";
      score: number;
      confidence: number;
      probabilities: Record<string, number>;
    };
  };
};

const FINAL_STATUSES = new Set<TicketStatus>([
  "processed",
  "human-review",
  "dead-letter",
]);

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);

    if (request.method !== "POST" || url.pathname !== "/tickets") {
      return Response.json({ error: "Not found" }, { status: 404 });
    }

    let input: unknown;

    try {
      input = await request.json();
    } catch {
      return Response.json({ error: "Invalid JSON" }, { status: 400 });
    }

    if (!isRecord(input) || typeof input.body !== "string" || input.body.trim() === "") {
      return Response.json(
        { error: "body must be a non-empty string" },
        { status: 400 },
      );
    }

    const id = crypto.randomUUID();
    const body = input.body.trim();
    const createdAt = new Date().toISOString();

    await env.DB.prepare(
      `INSERT INTO tickets (id, body, status, created_at)
       VALUES (?1, ?2, 'queued', ?3)`,
    )
      .bind(id, body, createdAt)
      .run();

    try {
      await env.TICKET_QUEUE.send({ ticketId: id });
    } catch (error) {
      await env.DB.prepare(
        `UPDATE tickets
         SET status = 'enqueue_failed', last_error = ?1
         WHERE id = ?2`,
      )
        .bind(errorMessage(error), id)
        .run();

      return Response.json(
        { id, status: "enqueue_failed" },
        { status: 503 },
      );
    }

    return Response.json({ id, status: "queued" }, { status: 202 });
  },

  async queue(batch: MessageBatch<TicketMessage>, env: Env): Promise<void> {
    if (batch.queue === "jev-ticket-routing-dlq") {
      for (const message of batch.messages) {
        await env.DB.prepare(
          `UPDATE tickets
           SET status = 'dead-letter'
           WHERE id = ?1`,
        )
          .bind(message.body.ticketId)
          .run();

        message.ack();
      }

      return;
    }

    for (const message of batch.messages) {
      await consumeTicket(message, env);
    }
  },
};

async function consumeTicket(
  message: Message<TicketMessage>,
  env: Env,
): Promise<void> {
  const ticket = await env.DB.prepare(
    `SELECT id, body, status, attempts
     FROM tickets
     WHERE id = ?1`,
  )
    .bind(message.body.ticketId)
    .first<TicketRow>();

  if (ticket === null) {
    console.error("Ticket not found", { ticketId: message.body.ticketId });
    message.ack();
    return;
  }

  if (FINAL_STATUSES.has(ticket.status)) {
    message.ack();
    return;
  }

  try {
    await env.DB.prepare(
      `UPDATE tickets
       SET status = 'processing', attempts = ?1, last_error = NULL
       WHERE id = ?2`,
    )
      .bind(message.attempts, ticket.id)
      .run();

    const result = await evaluateTicket(ticket.body, env);
    const department = result.answers.department.choice;
    const manualReview = result.answers.manual_review.noul;
    const urgency = result.answers.urgency;

    const finalStatus: TicketStatus =
      manualReview >= 0.8 ? "human-review" : "processed";
    const finalRoute =
      finalStatus === "human-review" ? "human-review" : department;

    await env.DB.prepare(
      `UPDATE tickets
       SET status = ?1,
           jev_model = ?2,
           jev_answers_json = ?3,
           department = ?4,
           department_probability = ?5,
           department_confidence = ?6,
           manual_review_probability = ?7,
           urgency_score = ?8,
           urgency_confidence = ?9,
           final_route = ?10,
           attempts = ?11,
           last_error = NULL,
           processed_at = ?12
       WHERE id = ?13`,
    )
      .bind(
        finalStatus,
        result.model,
        JSON.stringify(result.answers),
        department,
        result.answers.department.probabilities[department] ?? 0,
        result.answers.department.confidence,
        manualReview,
        urgency.score,
        urgency.confidence,
        finalRoute,
        message.attempts,
        new Date().toISOString(),
        ticket.id,
      )
      .run();

    message.ack();
  } catch (error) {
    const detail = errorMessage(error);

    try {
      await env.DB.prepare(
        `UPDATE tickets
         SET status = 'retrying', attempts = ?1, last_error = ?2
         WHERE id = ?3`,
      )
        .bind(message.attempts, detail, ticket.id)
        .run();
    } catch (updateError) {
      console.error("Failed to record retry state", {
        ticketId: ticket.id,
        error: errorMessage(updateError),
      });
    }

    message.retry();
  }
}

async function evaluateTicket(body: string, env: Env): Promise<JevResult> {
  const response: unknown = await env.AI.run("typesafe/jev", {
    state: body,
    questions: {
      department: {
        type: "choice",
        instructions: "Which team should handle this support request?",
        criteria: {
          account: "Login, password, profile, or account security issues",
          billing: "Charges, invoices, refunds, or subscriptions",
          technical: "Product bugs, outages, or integrations",
          other: "Requests that do not fit the other departments",
        },
      },
      manual_review: {
        type: "noul",
        instructions: "Should a human review this request before routing?",
        criteria: {
          true: "The request is ambiguous, sensitive, or requires human judgment",
          false: "The request can be routed by the automated flow",
        },
      },
      urgency: {
        type: "score",
        instructions: "How urgent is this request?",
        criteria: [
          "Normal: routine handling is sufficient",
          "Urgent: delayed handling may materially affect the customer",
          "Critical: immediate handling is required",
        ],
      },
    },
  });

  return parseJevResult(response);
}

function parseJevResult(value: unknown): JevResult {
  if (!isRecord(value) || typeof value.model !== "string" || !isRecord(value.answers)) {
    throw new Error("Invalid Jev response envelope");
  }

  const department = value.answers.department;
  const manualReview = value.answers.manual_review;
  const urgency = value.answers.urgency;

  if (
    !isRecord(department) ||
    department.type !== "choice" ||
    !isDepartment(department.choice) ||
    typeof department.confidence !== "number" ||
    !isNumberRecord(department.probabilities)
  ) {
    throw new Error("Invalid Jev department answer");
  }

  if (
    !isRecord(manualReview) ||
    manualReview.type !== "noul" ||
    typeof manualReview.noul !== "number"
  ) {
    throw new Error("Invalid Jev manual_review answer");
  }

  if (
    !isRecord(urgency) ||
    urgency.type !== "score" ||
    typeof urgency.score !== "number" ||
    typeof urgency.confidence !== "number" ||
    !isNumberRecord(urgency.probabilities)
  ) {
    throw new Error("Invalid Jev urgency answer");
  }

  return value as JevResult;
}

function isDepartment(value: unknown): value is Department {
  return (
    value === "account" ||
    value === "billing" ||
    value === "technical" ||
    value === "other"
  );
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function isNumberRecord(value: unknown): value is Record<string, number> {
  return (
    isRecord(value) &&
    Object.values(value).every((entry) => typeof entry === "number")
  );
}

function errorMessage(error: unknown): string {
  return error instanceof Error ? error.message : String(error);
}
