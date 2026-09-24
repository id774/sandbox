// Demonstrates semantic linting of a TypeScript function by splitting the
// check into narrow Jev-shaped Noul judgments and a Score severity, then
// letting a deterministic CI policy decide failure. The Jev response is fixed
// locally, so no network access or credentials are needed. The fixed fixture
// contains defects, so the expected exit status is 1.
// Run: tsc --target es2020 lint.ts && node lint.js

declare const process: { exitCode?: number };

interface NoulAnswer {
    noul: number;
}

interface ScoreAnswer {
    score: number;
    confidence: number;
    legend: Record<string, string>;
    probabilities: Record<string, number>;
}

interface LintResponse {
    issues: Record<string, NoulAnswer>;
    severity: ScoreAnswer;
}

const source = [
    "function canCheckout(user: User | null) {",
    "    if (user) return false;",
    "    return user.balance > 0;",
    "}",
].join("\n");

const issueThreshold = 0.8;
const severityThreshold = 2.5;

// Fixed demonstration data, not a live model result.
function judgeSource(input: string): LintResponse {
    void input;
    return {
        issues: {
            inverted_condition: { noul: 0.92 },
            unhandled_null: { noul: 0.99 },
        },
        severity: {
            score: 2.8,
            confidence: 0.8,
            legend: {
                "0": "None",
                "1": "Minor",
                "2": "Major",
                "3": "Critical",
            },
            probabilities: {
                "0": 0.0,
                "1": 0.02,
                "2": 0.18,
                "3": 0.8,
            },
        },
    };
}

const response = judgeSource(source);

const issues = Object.keys(response.issues)
    .filter((name) => response.issues[name].noul >= issueThreshold);
const severity = response.severity.score;

console.log(`issues: ${issues.join(", ")}`);
console.log(`severity: ${severity}`);

if (issues.length > 0 || severity >= severityThreshold) {
    process.exitCode = 1;
}
