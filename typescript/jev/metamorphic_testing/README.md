# Jev Metamorphic Testing

## Purpose

This sample shows how to apply metamorphic testing to Jev's probabilistic
security-review decision. Instead of checking a single input against a fixed
expected result, it checks that a relationship holds between the final
decisions for two related inputs:

- **`same-decision`**: adding information that is irrelevant to the business
  decision must not change the final `auto` / `review` decision.
- **`not-less-risky`**: adding information that signals a security risk must
  not make the final decision less risky than it was before that information
  was added (`review` must never regress to `auto`).

As in the sibling `regression_testing` sample, two layers are kept separate:

- **Deterministic decision logic.** `decide()` takes a fixed, Jev-shaped
  response and applies a fixed `0.8` threshold to produce a final `auto` /
  `review` decision. It is unit-tested against fixed inputs and never calls
  Jev.
- **Live metamorphic evaluation.** For each metamorphic case, both the
  source input and the follow-up input are sent to the actual `typesafe/jev`
  model through the Workers AI `AI` binding, and the relation between the two
  resulting final decisions is asserted.

The pass/fail criterion for the live evaluation is the relation between the
two final decisions, not an exact `noul` value or a fixed minimum change in
`noul`. `model` and `noul` for both inputs, and the `noul` delta between
them, are recorded only as diagnostic information; they are not asserted
against a golden value.

## Requirements

- Node.js / npm
- a Cloudflare account with access to Workers AI
- for the live evaluation, Wrangler authenticated against that Cloudflare
  account

## Setup

```sh
npm install
npm run types
```

`npm run types` generates `worker-configuration.d.ts` from `wrangler.jsonc`.
This file is a generated build artifact and is not committed.

## Unit test

```sh
npm run test:unit
```

This runs `test/decision.spec.ts`, which exercises `decide()` against fixed
`JevEscalationResult` values just below, at, and just above the `0.8`
threshold. It does not call Jev. Expected result: 3 tests pass.

## Live metamorphic evaluation

```sh
npm run eval:metamorphic
```

This runs `test/metamorphic.spec.ts`, which uses the Workers AI `AI` binding
(`remote: true`) to call the actual `typesafe/jev` model for both the source
and follow-up input of each metamorphic case in `test/fixtures.ts`, computes
the final decision for each, and asserts that the case's relation holds
between the source decision and the follow-up decision:

- `same-decision`: the follow-up decision must equal the source decision.
- `not-less-risky`: ranking `auto` below `review`, the follow-up decision's
  rank must be greater than or equal to the source decision's rank (only a
  `review` -> `auto` follow-up fails).

Each case also prints a diagnostic JSON line with the case name, the
relation, the source model, source `noul`, source decision, follow-up model,
follow-up `noul`, follow-up decision, and the `noul` delta between the two.

Running this command invokes Workers AI, which is billed like other Workers
AI usage; whether a charge is actually incurred depends on the account's
plan and usage.

## Files

- `src/decision.ts`: the fixed-threshold `decide()` function and the
  `JevEscalationResult` / `Decision` types.
- `src/jev.ts`: `evaluateWithJev()`, which calls `typesafe/jev` through the
  Workers AI `AI` binding.
- `src/relations.ts`: the `MetamorphicRelation` type and `relationHolds()`,
  which evaluates `same-decision` and `not-less-risky` against a pair of
  final decisions.
- `src/index.ts`: a minimal Workers entrypoint that returns a fixed response;
  it does not call Jev.
- `test/fixtures.ts`: the metamorphic cases, each with a source input, a
  follow-up input, and the relation expected to hold between their final
  decisions.
- `test/decision.spec.ts`: unit tests for `decide()` against fixed inputs.
- `test/metamorphic.spec.ts`: the live metamorphic evaluation against
  `typesafe/jev`.
- `test/tsconfig.json`: enables the Cloudflare Vitest plugin's test runtime
  types.
- `vitest.config.ts`: configures the Cloudflare Workers Vitest integration,
  separating the deterministic unit test project from the live evaluation
  project.
- `wrangler.jsonc`: Worker configuration, including the `AI` binding.
- `tsconfig.json`: project-wide TypeScript compiler options.
- `package.json` / `package-lock.json`: project dependencies and scripts.

## Source / Attribution

- Cloudflare Workers AI, Jev documentation:
  <https://developers.cloudflare.com/ai/models/typesafe/jev/>
- Cloudflare Workers Vitest integration documentation:
  <https://developers.cloudflare.com/workers/testing/vitest-integration/>
- Cloudflare local development / remote bindings documentation:
  <https://developers.cloudflare.com/workers/local-development/>
- TypeSafe workflow evals:
  <https://evals.typesafe.ai/>
