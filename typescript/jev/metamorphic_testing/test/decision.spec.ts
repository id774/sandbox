// decision.spec.ts: Unit tests for the fixed-threshold decision
//
// Description:
// Checks decide() against fixed Jev-shaped results around the review
// threshold. It does not call Jev.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm run test:unit
//
// Requirements:
// - Node.js 22 or later, with the dependencies installed by npm install
//   (see src/index.ts for tool versions)
// - No network access or credentials are needed

import { describe, expect, it } from "vitest";
import { decide, type JevEscalationResult } from "../src/decision";

function result(noul: number): JevEscalationResult {
  return {
    model: "test-model",
    answers: {
      escalate: {
        type: "noul",
        noul,
      },
    },
  };
}

describe("decide", () => {
  it("returns auto below the threshold", () => {
    expect(decide(result(0.79))).toBe("auto");
  });

  it("returns review at the threshold", () => {
    expect(decide(result(0.8))).toBe("review");
  });

  it("returns review above the threshold", () => {
    expect(decide(result(0.81))).toBe("review");
  });
});
