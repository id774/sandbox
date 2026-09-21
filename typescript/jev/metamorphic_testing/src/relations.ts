import type { Decision } from "./decision";

export type MetamorphicRelation = "same-decision" | "not-less-risky";

const DECISION_RANK: Record<Decision, number> = {
  auto: 0,
  review: 1,
};

export function relationHolds(
  relation: MetamorphicRelation,
  sourceDecision: Decision,
  followUpDecision: Decision,
): boolean {
  switch (relation) {
    case "same-decision":
      return followUpDecision === sourceDecision;
    case "not-less-risky":
      return DECISION_RANK[followUpDecision] >= DECISION_RANK[sourceDecision];
  }
}
