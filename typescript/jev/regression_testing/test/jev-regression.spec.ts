// jev-regression.spec.ts: Live Jev regression evaluation
//
// Description:
// For each case in fixtures.ts, sends the input to typesafe/jev through the
// Workers AI binding and asserts that the final decision matches the
// expected decision. Model and noul values are printed only as
// diagnostics.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com
//
// Usage:
//     npm run eval:jev
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
