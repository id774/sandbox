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
});
