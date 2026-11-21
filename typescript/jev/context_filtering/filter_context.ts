// filter_context.ts: Jev-shaped relevance filtering of candidate context
//
// Description:
// Demonstrates filtering already retrieved candidate context by Jev-shaped
// Noul relevance so that deterministic code chooses what is passed to a later
// processing stage. The Jev response is fixed locally, so no network access or
// credentials are needed.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Build / Run:
//     tsc --target es2020 filter_context.ts && node filter_context.js
//
// Requirements:
// - Node.js runtime
// - TypeScript compiler
// - No third-party package is required
//
// Verified Environment:
// Tested with TypeScript 6.0.2 and Node.js 22.23.5.

interface NoulAnswer {
    noul: number;
}

interface Candidate {
    id: string;
    description: string;
}

const query = "Investigate retry handling after authentication failures.";

const candidates: Candidate[] = [
    { id: "auth", description: "src/auth/retry.ts: retry handling for 401 and 429" },
    { id: "ui", description: "src/ui/theme.ts: dark mode colors" },
    { id: "billing", description: "src/billing/invoice.ts: invoice generation" },
];

const threshold = 0.7;

// Fixed demonstration data, not a live model result.
const relevance: Record<string, NoulAnswer> = {
    auth: { noul: 0.96 },
    ui: { noul: 0.05 },
    billing: { noul: 0.12 },
};

function judgeRelevance(input: string, candidate: Candidate): NoulAnswer {
    void input;
    const answer = relevance[candidate.id];
    if (answer === undefined) {
        throw new Error(`Missing relevance for candidate: ${candidate.id}`);
    }
    return answer;
}

const selected = candidates
    .filter((candidate) => judgeRelevance(query, candidate).noul >= threshold)
    .map((candidate) => candidate.id);

console.log(`query: ${query}`);
console.log(`threshold: ${threshold}`);
console.log(`selected context: ${selected.join(", ")}`);
