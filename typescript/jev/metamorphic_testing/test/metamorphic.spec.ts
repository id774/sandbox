// metamorphic.spec.ts: Live Jev metamorphic relation evaluation
//
// Description:
// For each case in fixtures.ts, sends the source and follow-up inputs to
// typesafe/jev through the Workers AI binding, computes both final
// decisions, and asserts that the case's metamorphic relation holds. Model
// and noul values are printed only as diagnostics.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm run eval:metamorphic
//
// Requirements:
// - Node.js 22 or later, with the dependencies installed by npm install
//   (see src/index.ts for tool versions)
// - A Cloudflare account with access to Workers AI, with Wrangler
//   authenticated against it
//
// Notes:
// - This evaluation makes live Workers AI calls and may consume Workers AI
//   usage.

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
