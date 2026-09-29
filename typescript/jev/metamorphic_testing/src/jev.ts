// jev.ts: Jev escalation evaluation through the Workers AI binding
//
// Description:
// Supporting module of the Jev metamorphic testing sample that calls
// typesafe/jev through the Workers AI binding. See src/index.ts for the
// sample context and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import type { JevEscalationResult } from "./decision";

export async function evaluateWithJev(
  ai: Ai,
  state: string,
): Promise<JevEscalationResult> {
  const response = await ai.run("typesafe/jev", {
    state,
    questions: {
      escalate: {
        type: "noul",
        instructions:
          "Should this request be escalated for manual security review?",
        criteria: {
          true: "The request warrants human security review",
          false: "The request can follow the normal automated flow",
        },
      },
    },
  });

  return response as JevEscalationResult;
}
