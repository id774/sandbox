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
