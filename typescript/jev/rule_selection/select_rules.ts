// select_rules.ts: Jev-shaped selection of relevant standing rules
//
// Description:
// Demonstrates selecting only the standing rules relevant to the current
// request by applying a deterministic threshold to Jev-shaped Noul relevance
// judgments. The Jev response is fixed locally, so no network access or
// credentials are needed.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     tsc --target es2020 select_rules.ts && node select_rules.js
//
// Requirements:
// - Node.js 20 or later
// - TypeScript 5.0 or later
// - No third-party package is required

interface NoulAnswer {
    noul: number;
}

interface Rule {
    id: string;
    text: string;
}

const request = "Fix the checkout discount calculation.";

const rules: Rule[] = [
    { id: "payments", text: "Use integer cents for all monetary arithmetic." },
    { id: "release", text: "Update the release checklist before tagging a version." },
    { id: "language", text: "Write user-facing messages in plain English." },
];

const threshold = 0.6;

// Fixed demonstration data, not a live model result.
const relevance: Record<string, NoulAnswer> = {
    payments: { noul: 0.94 },
    release: { noul: 0.08 },
    language: { noul: 0.12 },
};

function judgeRelevance(input: string, rule: Rule): NoulAnswer {
    void input;
    const answer = relevance[rule.id];
    if (answer === undefined) {
        throw new Error(`Missing relevance for rule: ${rule.id}`);
    }
    return answer;
}

const selected = rules
    .filter((rule) => judgeRelevance(request, rule).noul >= threshold)
    .map((rule) => rule.id);

console.log(`request: ${request}`);
console.log(`threshold: ${threshold}`);
console.log(`selected rules: ${selected.join(", ")}`);
