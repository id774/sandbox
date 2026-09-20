# Jev Regression Testing

## Purpose

This sample shows how to regression-test an application's use of Jev on
Cloudflare Workers AI while keeping two layers clearly separated:

- **Deterministic decision logic.** `decide()` takes a fixed,
  Jev-shaped response and applies a fixed `0.8` threshold to produce a final
  `auto` / `review` decision. It is unit-tested against fixed inputs and
  never calls Jev.
- **Live regression evaluation.** A fixed set of evaluation cases is sent to
  the actual `typesafe/jev` model through the Workers AI `AI` binding, and
  the resulting final `auto` / `review` decision is compared against each
  case's expected decision.

The primary pass/fail criterion for the live evaluation is that final
decision match, not an exact `noul` value. `model` and `noul` are recorded
only as diagnostic information for investigating a mismatch; they are not
asserted against a golden value.

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
`JevEscalationResult` values. It does not call Jev. Expected result: 2 tests
pass.

## Live regression evaluation

```sh
npm run eval:jev
```

This runs `test/jev-regression.spec.ts`, which uses the Workers AI `AI`
binding (`remote: true`) to call the actual `typesafe/jev` model for each of
the three fixed evaluation cases in `test/fixtures.ts`, and asserts that the
final decision matches each case's expected decision. Each case also prints
a diagnostic JSON line with the case name, the model name, the raw `noul`
value, the computed decision, and the expected decision.

Running this command invokes Workers AI, which is billed like other Workers
AI usage; whether a charge is actually incurred depends on the account's
plan and usage.

## Files

- `src/decision.ts`: the fixed-threshold `decide()` function and the
  `JevEscalationResult` / `Decision` types.
- `src/jev.ts`: `evaluateWithJev()`, which calls `typesafe/jev` through the
  Workers AI `AI` binding.
- `src/index.ts`: a minimal Workers entrypoint that returns a fixed response;
  it does not call Jev.
- `test/fixtures.ts`: the three fixed evaluation cases and their expected
  decisions.
- `test/decision.spec.ts`: unit tests for `decide()` against fixed inputs.
- `test/jev-regression.spec.ts`: the live regression evaluation against
  `typesafe/jev`.
- `test/tsconfig.json`: enables the Cloudflare Vitest plugin's test runtime
  types.
- `vitest.config.ts`: configures the Cloudflare Workers Vitest integration.
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
