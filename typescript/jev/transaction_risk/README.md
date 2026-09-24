# Jev Transaction Risk

## Purpose

This sample demonstrates evaluating deterministic hard rules before a Jev
judgment, sending only ambiguous transactions to a Jev-shaped response, and
deciding the final action in code.

## Self-contained / no live API call

This sample does not call Jev or any other network service, and it does not
use any real transaction, wallet address, or account. `judgeTransaction()` in
`assess_risk.ts` returns a fixed local Jev-shaped response.

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
tsc --target es2020 assess_risk.ts && node assess_risk.js
```

The command generates a local `assess_risk.js`; generated JavaScript is not committed
to the repository.

## Observable behavior

The hard rules are evaluated first, without a Jev call:

1. A blocked address gives `FREEZE` from `hard_rule`.
2. An amount above `500000` USD gives `MANUAL_REVIEW` from `hard_rule`.

For the remaining transactions, the fixed response gives risk score `2.2`,
pattern `rapid_in_out`, and freeze probability `0.84`. The post-Jev policy
gives `FREEZE` for a withdrawal with risk `>= 2.5` or freeze `>= 0.8`,
otherwise `MANUAL_REVIEW` for risk `>= 1.5`, and otherwise `PASS`.

The blocked transfer is a `1000` USD withdrawal to `0xBLOCKED`. The
evaluated transfer is a `120000` USD withdrawal to `0xSAFE` with four
transfers in 24 hours and rapid in-out movement. Only the evaluated transfer
reaches the Jev mock, so the call count is one.

Expected stdout:

```text
blocked transfer: FREEZE (hard_rule)
evaluated transfer: FREEZE (jev)
Jev calls: 1
```

The process exits with status `0`.

## Files

- `assess_risk.ts`: the standalone sample implementation.

## Source / Attribution

The decision boundary in this sample is an independent minimal implementation.
The following projects were used as design references only; no source code is
copied from them.

- TypeSafe AI JavaScript SDK:
  <https://github.com/typesafe-ai/typesafe-sdk-js>
- `klauswg/jev-guard`: <https://github.com/klauswg/jev-guard>
