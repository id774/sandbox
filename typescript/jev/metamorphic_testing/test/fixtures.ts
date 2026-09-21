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
