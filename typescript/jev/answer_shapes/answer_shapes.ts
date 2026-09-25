// Demonstrates choosing Jev Choice, Score, and Noul questions by the answer
// shape and control flow that downstream code needs: a validated finite label
// for a switch, an ordered scale for numeric comparison, and a proposition
// probability for a threshold. The Jev response is fixed local data, not a
// live model call.
// Run: tsc --target es2020 answer_shapes.ts && node answer_shapes.js

const handlers = [
    "account",
    "billing",
    "technical",
    "other",
] as const;

type Handler = typeof handlers[number];

interface SupportState {
    subject: string;
    message: string;
}

interface NoulAnswer {
    type: "noul";
    noul: number;
}

interface ChoiceAnswer {
    type: "choice";
    choice: string;
    confidence: number;
    probabilities: Record<string, number>;
}

interface ScoreAnswer {
    type: "score";
    score: number;
    confidence: number;
    legend: Record<string, string>;
    probabilities: Record<string, number>;
}

interface JevResponse {
    answers: {
        handler: ChoiceAnswer;
        urgency: ScoreAnswer;
        needs_human_review: NoulAnswer;
    };
}

const questions = {
    handler: {
        type: "choice",
        instructions: "Choose the handler that should process this support request.",
        criteria: {
            account: "Login, password, profile, or authentication issues.",
            billing: "Charges, invoices, refunds, or subscriptions.",
            technical: "Application failures, bugs, outages, or integrations.",
            other: "Requests that do not fit any of the other handlers.",
        },
    },
    urgency: {
        type: "score",
        instructions: "Rate how urgently this support request needs a response.",
        criteria: [
            "Normal",
            "This week",
            "Today",
            "Immediate",
        ],
    },
    needs_human_review: {
        type: "noul",
        instructions: "Decide whether a human should review this request before automated handling continues.",
        criteria: {
            true: "Human review is required.",
            false: "Automated handling can continue.",
        },
    },
} as const;

let jevCallCount = 0;

// Local stand-in for the Jev binding. Fixed demonstration data, not a live
// model result.
const env = {
    AI: {
        run(model: string, input: unknown): JevResponse {
            void model;
            void input;
            jevCallCount += 1;
            return {
                answers: {
                    handler: {
                        type: "choice",
                        choice: "technical",
                        confidence: 0.82,
                        probabilities: { account: 0.08, billing: 0.05, technical: 0.82, other: 0.05 },
                    },
                    urgency: {
                        type: "score",
                        score: 2.4,
                        confidence: 0.76,
                        legend: { "0": "Normal", "1": "This week", "2": "Today", "3": "Immediate" },
                        probabilities: { "0": 0.05, "1": 0.10, "2": 0.45, "3": 0.40 },
                    },
                    needs_human_review: {
                        type: "noul",
                        noul: 0.78,
                    },
                },
            };
        },
    },
};

function judgeSupportRequest(state: SupportState): JevResponse {
    return env.AI.run(
        "typesafe/jev",
        {
            state,
            questions,
        },
    );
}

function isHandler(value: string): value is Handler {
    return handlers.includes(value as Handler);
}

function routeHandler(handler: Handler): string {
    switch (handler) {
        case "account":
            return "/queues/account";
        case "billing":
            return "/queues/billing";
        case "technical":
            return "/queues/technical";
        case "other":
            return "/queues/general";
    }
}

const EXPEDITE_THRESHOLD = 2;

function isExpedited(score: number): boolean {
    return score >= EXPEDITE_THRESHOLD;
}

const HUMAN_REVIEW_THRESHOLD = 0.70;

function needsHumanReview(probability: number): boolean {
    return probability >= HUMAN_REVIEW_THRESHOLD;
}

const state: SupportState = {
    subject: "Production API failure",
    message: "Requests have returned 500 since this morning. Please investigate today.",
};

const response = judgeSupportRequest(state);

const handler = response.answers.handler.choice;
if (!isHandler(handler)) {
    throw new Error(`Unexpected handler: ${handler}`);
}
const urgencyScore = response.answers.urgency.score;
const reviewProbability = response.answers.needs_human_review.noul;

console.log(`handler: ${handler}`);
console.log(`queue: ${routeHandler(handler)}`);
console.log(`urgency score: ${urgencyScore}`);
console.log(`expedited: ${isExpedited(urgencyScore)}`);
console.log(`human review probability: ${reviewProbability}`);
console.log(`human review: ${needsHumanReview(reviewProbability)}`);
console.log(`Jev calls: ${jevCallCount}`);
