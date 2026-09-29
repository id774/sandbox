// relations.ts: Metamorphic relations between two final decisions
//
// Description:
// Supporting module of the Jev metamorphic testing sample. See src/index.ts
// for the sample context and requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

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
