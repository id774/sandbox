# Jev Rule Selection

## Purpose

This sample demonstrates judging the relevance of several standing rules to
the current request with Jev-shaped `Noul` probabilities, then letting
deterministic code select only the rules that meet a threshold.

## Self-contained / no live API call

This sample does not call Jev or any other network service. `judgeRelevance()`
in `select_rules.ts` returns fixed local Jev-shaped `Noul` values.

No API key, token, account ID, environment variable, or other credential is
required.

The fixed response is demonstration data. It illustrates the decision boundary
used by the sample and must not be interpreted as a live model result.

## Requirements

- `tsc` (TypeScript compiler)
- `node` (JavaScript runtime)

No third-party package is required.

## Build / Run

```sh
tsc --target es2020 select_rules.ts && node select_rules.js
```

The command generates a local `select_rules.js`; generated JavaScript is not committed
to the repository.

## Observable behavior

The fixed request is `Fix the checkout discount calculation.` The standing
rules are `payments`, `release`, and `language`, with fixed relevance
`0.94`, `0.08`, and `0.12`. Rules with relevance `>= 0.6` are selected,
so only `payments` is applied.

Expected stdout:

```text
request: Fix the checkout discount calculation.
threshold: 0.6
selected rules: payments
```

The process exits with status `0`.

## Files

- `select_rules.ts`: the standalone sample implementation.

## Source / Attribution

The decision boundary in this sample is an independent minimal implementation.
The following projects were used as design references only; no source code is
copied from them.

- TypeSafe AI JavaScript SDK:
  <https://github.com/typesafe-ai/typesafe-sdk-js>
- `EliaAlberti/jev-rules`: <https://github.com/EliaAlberti/jev-rules>
