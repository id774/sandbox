// Demonstrates screening a fixed candidate profile fixture against required
// criteria. Jev-shaped Choice answers select each criterion status and one
// evidence excerpt ID from a finite set, and deterministic code builds the
// potential_match state. The Jev response is fixed locally, so no network
// access or credentials are needed.
// Run: tsc --target es2020 screen_candidate.ts && node screen_candidate.js

const statuses = ["met", "not_met", "unknown"] as const;
const evidenceIds = ["e0", "e1", "e2", "none"] as const;

type Status = typeof statuses[number];
type EvidenceId = typeof evidenceIds[number];

interface ChoiceAnswer {
    choice: string;
    confidence: number;
    probabilities: Record<string, number>;
}

interface ScreeningResponse {
    role: ChoiceAnswer;
    location: ChoiceAnswer;
    evidence: ChoiceAnswer;
}

interface Profile {
    title: string;
    excerpts: Record<string, string>;
}

const profile: Profile = {
    title: "Solutions Engineer",
    excerpts: {
        e0: "Tokyo, Japan",
        e1: "Solutions Engineer at Example Corp",
        e2: "Built customer-facing integrations and deployment tooling",
    },
};

// Fixed demonstration data, not a live model result.
function judgeProfile(input: Profile): ScreeningResponse {
    void input;
    return {
        role: {
            choice: "met",
            confidence: 0.9,
            probabilities: { met: 0.9, not_met: 0.04, unknown: 0.06 },
        },
        location: {
            choice: "met",
            confidence: 0.97,
            probabilities: { met: 0.97, not_met: 0.01, unknown: 0.02 },
        },
        evidence: {
            choice: "e2",
            confidence: 0.82,
            probabilities: { e0: 0.02, e1: 0.14, e2: 0.82, none: 0.02 },
        },
    };
}

function toStatus(value: string): Status {
    if (!statuses.includes(value as Status)) {
        throw new Error(`Unexpected status: ${value}`);
    }
    return value as Status;
}

function toEvidenceId(value: string): EvidenceId {
    if (!evidenceIds.includes(value as EvidenceId)) {
        throw new Error(`Unexpected evidence ID: ${value}`);
    }
    return value as EvidenceId;
}

const response = judgeProfile(profile);
const roleStatus = toStatus(response.role.choice);
const locationStatus = toStatus(response.location.choice);
const evidence = toEvidenceId(response.evidence.choice);

// potential_match marks a candidate for human review; it is not a hiring decision.
const potentialMatch = roleStatus === "met" && locationStatus === "met" && evidence !== "none";

console.log(`potential match: ${potentialMatch}`);
console.log(`evidence: ${evidence}`);
