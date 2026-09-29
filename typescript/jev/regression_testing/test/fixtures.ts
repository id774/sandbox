// fixtures.ts: Fixed cases for the live Jev regression evaluation
//
// Description:
// Supporting fixture of the Jev regression testing sample, used by
// jev-regression.spec.ts. See src/index.ts for the sample context and
// requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

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
