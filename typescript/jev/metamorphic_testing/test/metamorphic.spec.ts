import { env } from "cloudflare:workers";
import { describe, expect, it } from "vitest";
import { decide } from "../src/decision";
import { evaluateWithJev } from "../src/jev";
import { relationHolds } from "../src/relations";
import { cases } from "./fixtures";

describe("Jev metamorphic relations", () => {
  for (const testCase of cases) {
    it(testCase.name, async () => {
      const sourceResult = await evaluateWithJev(env.AI, testCase.source);
      const followUpResult = await evaluateWithJev(env.AI, testCase.followUp);

      const sourceDecision = decide(sourceResult);
      const followUpDecision = decide(followUpResult);

      console.info(
        JSON.stringify({
          caseName: testCase.name,
          relation: testCase.relation,
          sourceModel: sourceResult.model,
          sourceNoul: sourceResult.answers.escalate.noul,
          sourceDecision,
          followUpModel: followUpResult.model,
          followUpNoul: followUpResult.answers.escalate.noul,
          followUpDecision,
          noulDelta:
            followUpResult.answers.escalate.noul -
            sourceResult.answers.escalate.noul,
        }),
      );

      expect(
        relationHolds(testCase.relation, sourceDecision, followUpDecision),
      ).toBe(true);
    });
  }
});
