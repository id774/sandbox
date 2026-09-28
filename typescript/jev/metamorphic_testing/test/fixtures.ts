// fixtures.ts: Metamorphic cases for the live Jev evaluation
//
// Description:
// Supporting fixture of the Jev metamorphic testing sample, used by
// metamorphic.spec.ts. See src/index.ts for the sample context and
// requirements.
//
// Author: id774 (More info: https://id774.net)
// Source Code: https://github.com/id774/sandbox
// License: The GPL version 3, or LGPL version 3 (Dual License).
// Contact: idnanashi@gmail.com

import type { MetamorphicRelation } from "../src/relations";

export type MetamorphicCase = {
  name: string;
  relation: MetamorphicRelation;
  source: string;
  followUp: string;
};

export const cases: MetamorphicCase[] = [
  {
    name: "unrelated detail does not change the decision",
    relation: "same-decision",
    source: "I forgot my password and would like a password reset link.",
    followUp:
      "I forgot my password and would like a password reset link. My laptop is blue.",
  },
  {
    name: "added account takeover signal does not become less risky",
    relation: "not-less-risky",
    source: "I forgot my password and would like a password reset link.",
    followUp:
      "I forgot my password. My email address was changed without my permission and I cannot sign in.",
  },
];
