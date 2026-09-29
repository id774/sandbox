// decision.ts: Fixed-threshold decision for Jev escalation results
//
// Description:
// Supporting module of the Jev regression testing sample. See src/index.ts
// for the sample context and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

export type JevEscalationResult = {
  model: string;
  answers: {
    escalate: {
      type: "noul";
      noul: number;
    };
  };
};

export type Decision = "auto" | "review";

const REVIEW_THRESHOLD = 0.8;

export function decide(result: JevEscalationResult): Decision {
  return result.answers.escalate.noul >= REVIEW_THRESHOLD
    ? "review"
    : "auto";
}
