// Demonstrates evaluating deterministic hard rules before a Jev-shaped
// judgment, sending only ambiguous transactions to Jev, and deciding the final
// action in code. The transactions and the Jev response are fixed locally, so
// no network access or credentials are needed.
// Run: tsc --target es2020 assess_risk.ts && node assess_risk.js

type Action = "FREEZE" | "MANUAL_REVIEW" | "PASS";
type Source = "hard_rule" | "jev";

const patterns = ["normal", "rapid_in_out", "structuring", "unknown"] as const;

type Pattern = typeof patterns[number];

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

interface RiskResponse {
    risk: ScoreAnswer;
    pattern: ChoiceAnswer;
    freeze: NoulAnswer;
}

interface Transaction {
    address: string;
    direction: "deposit" | "withdrawal";
    usdAmount: number;
    count24h?: number;
    rapidInOut?: boolean;
}

interface Assessment {
    action: Action;
    source: Source;
}

const blockedAddresses = new Set(["0xBLOCKED"]);
const manualReviewAmount = 500000;

let jevCallCount = 0;

// Fixed demonstration data, not a live model result.
function judgeTransaction(input: Transaction): RiskResponse {
    void input;
    jevCallCount += 1;
    return {
        risk: {
            score: 2.2,
            confidence: 0.7,
            legend: {
                "0": "Low",
                "1": "Moderate",
                "2": "High",
                "3": "Severe",
            },
            probabilities: { "0": 0.02, "1": 0.12, "2": 0.7, "3": 0.16 },
        },
        pattern: {
            choice: "rapid_in_out",
            confidence: 0.81,
            probabilities: { normal: 0.05, rapid_in_out: 0.81, structuring: 0.1, unknown: 0.04 },
        },
        freeze: { noul: 0.84 },
    };
}

function isPattern(value: string): value is Pattern {
    return patterns.includes(value as Pattern);
}

function assess(transaction: Transaction): Assessment {
    if (blockedAddresses.has(transaction.address)) {
        return { action: "FREEZE", source: "hard_rule" };
    }
    if (transaction.usdAmount > manualReviewAmount) {
        return { action: "MANUAL_REVIEW", source: "hard_rule" };
    }

    const response = judgeTransaction(transaction);
    if (!isPattern(response.pattern.choice)) {
        throw new Error(`Unexpected pattern: ${response.pattern.choice}`);
    }

    const risk = response.risk.score;
    const freeze = response.freeze.noul;
    if (transaction.direction === "withdrawal" && (risk >= 2.5 || freeze >= 0.8)) {
        return { action: "FREEZE", source: "jev" };
    }
    if (risk >= 1.5) {
        return { action: "MANUAL_REVIEW", source: "jev" };
    }
    return { action: "PASS", source: "jev" };
}

const blockedTransfer: Transaction = {
    address: "0xBLOCKED",
    direction: "withdrawal",
    usdAmount: 1000,
};

const evaluatedTransfer: Transaction = {
    address: "0xSAFE",
    direction: "withdrawal",
    usdAmount: 120000,
    count24h: 4,
    rapidInOut: true,
};

const blocked = assess(blockedTransfer);
const evaluated = assess(evaluatedTransfer);

console.log(`blocked transfer: ${blocked.action} (${blocked.source})`);
console.log(`evaluated transfer: ${evaluated.action} (${evaluated.source})`);
console.log(`Jev calls: ${jevCallCount}`);
