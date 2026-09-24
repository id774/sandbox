# Jev Market State

## Purpose

This sample demonstrates ordinary code preparing precomputed market features
as state, Jev-shaped judgments returning a market interpretation, and a
deterministic quote policy using that interpretation.

## Self-contained / no live API call

This sample does not call Jev or any other network service, and it does not
use real market data, orders, or accounts. `judgeMarket()` in
`classify_market.ts` returns a fixed local Jev-shaped response.

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
tsc --target es2020 classify_market.ts && node classify_market.js
```

The command generates a local `classify_market.js`; generated JavaScript is not committed
to the repository.

## Observable behavior

The fixed features are spread `8.2` bps, order book imbalance `0.71`,
realized volatility `0.024`, inventory `0.35`, and drawdown `0.008`. A
drawdown `>= 0.02` is a hard risk veto that throws an error before any
judgment is used.

The fixed response gives regime `volatile`, direction `up`, toxic flow
`0.78`, liquidity stress `0.64`, and inventory pressure score `2.1`. The
spread multiplier is `1.5` when toxic flow or liquidity stress is `>= 0.7`,
and `1.0` otherwise. The inventory skew is the score, and the direction is
the choice.

Expected stdout:

```text
regime: volatile
direction: up
spread multiplier: 1.5
inventory skew: 2.1
```

The process exits with status `0`.

## Files

- `classify_market.ts`: the standalone sample implementation.

## Source / Attribution

The decision boundary in this sample is an independent minimal implementation.
The following projects were used as design references only; no source code is
copied from them.

- TypeSafe AI JavaScript SDK:
  <https://github.com/typesafe-ai/typesafe-sdk-js>
- `buberlo/jev-trader`: <https://github.com/buberlo/jev-trader>
