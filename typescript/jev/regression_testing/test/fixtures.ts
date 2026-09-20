import type { Decision } from "../src/decision";

export type EvalCase = {
  name: string;
  state: string;
  expectedDecision: Decision;
};

export const cases: EvalCase[] = [
  {
    name: "unknown device access",
    state:
      "My account was accessed from a device I do not recognize. Please secure it.",
    expectedDecision: "review",
  },
  {
    name: "ordinary password reset",
    state:
      "I forgot my password and would like a password reset link.",
    expectedDecision: "auto",
  },
  {
    name: "suspected account takeover",
    state:
      "My email address was changed without my permission and I cannot sign in.",
    expectedDecision: "review",
  },
];
