import { env } from "cloudflare:workers";
import { describe, expect, it } from "vitest";
import { decide } from "../src/decision";
import { evaluateWithJev } from "../src/jev";
import { cases } from "./fixtures";

describe("Jev regression", () => {
  for (const testCase of cases) {
    it(testCase.name, async () => {
      const result = await evaluateWithJev(env.AI, testCase.state);
      const decision = decide(result);

      console.info(
        JSON.stringify({
          caseName: testCase.name,
          model: result.model,
          noul: result.answers.escalate.noul,
          decision,
          expectedDecision: testCase.expectedDecision,
        }),
      );

      expect(decision).toBe(testCase.expectedDecision);
    });
  }
});
