# Jev Async Ticket Routing

## Purpose

This sample shows how to connect Jev to an asynchronous support-ticket
workflow on Cloudflare Workers.

`POST /tickets` stores a ticket in D1 and sends its ID to Cloudflare Queues.
The same Worker consumes the queued message, evaluates the ticket with
`typesafe/jev`, applies deterministic TypeScript routing rules, and writes the
Jev result and final state back to D1.

The sample also records retry state, sends repeatedly failing messages to a
Dead Letter Queue, and skips Jev when a redelivered ticket is already in a
final state.

## Requirements

- Node.js and npm
- a Cloudflare account with access to Workers AI, Queues, and D1
- Wrangler authenticated against that Cloudflare account when using the live
  Workers AI binding or creating remote resources

## Setup

Install the local development dependencies.

```sh
npm install
```

Create the Queue, Dead Letter Queue, and D1 database when using the sample
against a Cloudflare account.

```sh
npx wrangler queues create jev-ticket-routing
npx wrangler queues create jev-ticket-routing-dlq
npx wrangler d1 create jev-ticket-routing
```

Replace `<D1_DATABASE_ID>` in `wrangler.jsonc` with the ID returned by the D1
create command in the local working copy before using that remote database.
Do not commit account-specific resource identifiers.

Generate the Worker binding types.

```sh
npm run types
```

`worker-configuration.d.ts` is generated locally and is not committed.

Create the local D1 table.

```sh
npx wrangler d1 execute jev-ticket-routing \
  --local \
  --file=./migrations/0001_create_tickets.sql
```

Run the Worker locally.

```sh
npx wrangler dev
```

The AI binding uses `remote: true` because Workers AI is not simulated
locally. Running requests that reach Jev uses the Cloudflare account configured
for Wrangler and may consume Workers AI usage.

## Request

Submit a ticket with `POST /tickets`.

```sh
curl -s \
  -X POST \
  -H 'content-type: application/json' \
  -d '{"body":"I cannot log in after changing my password, and the reset email never arrives."}' \
  http://localhost:8787/tickets
```

A successful acceptance returns HTTP `202` with an ID and `queued` status.
Jev runs later in the Queue consumer rather than in the HTTP request.

## Routing

Jev evaluates three typed questions:

- `department`: `Choice` among `account`, `billing`, `technical`, and `other`
- `manual_review`: `Noul` for whether human review is required
- `urgency`: `Score` for request urgency

The application validates the Jev response before using it. A
`manual_review.noul` value of `0.8` or greater routes the ticket to
`human-review`; otherwise the selected department becomes the final route.

## States

The D1 row uses these processing states:

- `queued`: the ticket was stored and queued
- `enqueue_failed`: D1 storage succeeded but Queue submission failed
- `processing`: the consumer is processing the ticket
- `retrying`: processing failed and the message was requested for retry
- `processed`: automatic routing completed
- `human-review`: the application routed the ticket to human review
- `dead-letter`: the message reached the Dead Letter Queue

`processed`, `human-review`, and `dead-letter` are final states. If a message
for a ticket already in one of those states is delivered again, the consumer
acknowledges it without running Jev again.

Cloudflare Queues uses at-least-once delivery, so this final-state check reduces
duplicate work after completion but does not provide exactly-once execution.

## Retry and Dead Letter Queue

The normal Queue consumer is configured with `max_retries: 3` and
`jev-ticket-routing-dlq` as its Dead Letter Queue.

When processing fails, the Worker records `retrying`, the current delivery
attempt count, and the error text, then calls `message.retry()`. Messages that
reach the retry limit are delivered to the DLQ consumer, which records
`dead-letter` and acknowledges them.

## Files

- `src/index.ts`: HTTP producer, Queue consumer, Jev evaluation, routing, and
  D1 state updates.
- `migrations/0001_create_tickets.sql`: D1 schema for tickets and processing
  state.
- `wrangler.jsonc`: Workers AI, D1, Queue, and DLQ bindings.
- `tsconfig.json`: TypeScript compiler configuration.
- `package.json` / `package-lock.json`: local development dependencies.
- `.gitignore`: generated Wrangler state and binding types excluded from Git.

## References

- Cloudflare Workers AI, Jev:
  <https://developers.cloudflare.com/ai/models/typesafe/jev/>
- Cloudflare Queues, JavaScript APIs:
  <https://developers.cloudflare.com/queues/configuration/javascript-apis/>
- Cloudflare Queues, Dead Letter Queues:
  <https://developers.cloudflare.com/queues/configuration/dead-letter-queues/>
- Cloudflare Queues, delivery guarantees:
  <https://developers.cloudflare.com/queues/reference/delivery-guarantees/>
- Cloudflare D1, getting started:
  <https://developers.cloudflare.com/d1/get-started/>
- Cloudflare Workers, local development:
  <https://developers.cloudflare.com/workers/local-development/>
