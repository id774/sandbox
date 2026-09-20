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
