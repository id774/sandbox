// Demonstrates triaging a fixed email into a Jev-shaped Choice category, Score
// urgency, and Noul human-written probability, with deterministic code
// producing the displayed values. The Jev response is fixed locally, so no
// mailbox, network access, or credentials are needed.
// Run: tsc --target es2020 triage.ts && node triage.js

const trays = ["needs_reply", "fyi", "newsletter", "spam"] as const;

type Tray = typeof trays[number];

interface NoulAnswer {
    noul: number;
}

interface ChoiceAnswer {
    choice: string;
    confidence: number;
    probabilities: Record<string, number>;
}

interface ScoreAnswer {
    score: number;
    confidence: number;
    legend: Record<string, string>;
    probabilities: Record<string, number>;
}

interface TriageResponse {
    tray: ChoiceAnswer;
    urgency: ScoreAnswer;
    human: NoulAnswer;
}

interface Mail {
    from: string;
    subject: string;
    body: string;
}

const mail: Mail = {
    from: "customer@example.invalid",
    subject: "Production API is failing",
    body: "All requests have returned 500 since this morning. Please help today.",
};

// Fixed demonstration data, not a live model result.
function judgeMail(input: Mail): TriageResponse {
    void input;
    return {
        tray: {
            choice: "needs_reply",
            confidence: 0.97,
            probabilities: { needs_reply: 0.97, fyi: 0.02, newsletter: 0.0, spam: 0.01 },
        },
        urgency: {
            score: 4,
            confidence: 0.88,
            legend: {
                "0": "Whenever",
                "1": "This month",
                "2": "This week",
                "3": "Tomorrow",
                "4": "Today",
            },
            probabilities: { "0": 0.0, "1": 0.0, "2": 0.02, "3": 0.1, "4": 0.88 },
        },
        human: { noul: 0.96 },
    };
}

function isTray(value: string): value is Tray {
    return trays.includes(value as Tray);
}

const response = judgeMail(mail);
const tray = response.tray.choice;
if (!isTray(tray)) {
    throw new Error(`Unexpected tray: ${tray}`);
}

console.log(`tray: ${tray}`);
console.log(`urgency: ${Math.round(response.urgency.score) + 1}`);
console.log(`human probability: ${response.human.noul}`);
