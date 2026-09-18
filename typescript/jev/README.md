# Jev Decision Logic

## Purpose

Jev is TypeSafe AI's typed probabilistic model, served on Cloudflare Workers
AI, which returns structured outputs such as choice probabilities,
confidence, and a Score distribution instead of free-form text. This sample
shows how that typed output connects to ordinary business logic: treating
probability and confidence as distinct signals, checking probability
calibration against observed outcomes, deriving a decision threshold from
expected loss, and reading a Score as a distribution rather than a single
aggregate number.

## Self-contained / no live API call

This sample does not call the Jev API, Cloudflare Workers AI, or any other
network service. All data is fixed inside `decision.ts`. It requires no API
token, account ID, or other credential, and performs no network access.

## Requirements

- `tsc` (TypeScript compiler)
- `node` (JavaScript runtime)

No third-party package is required.

## Build / Run

```sh
tsc --target es2020 decision.ts && node decision.js
```

## Observable output

Running the sample prints four sections to stdout:

- **A. Choice probability vs. confidence** — the selected choice's
  probabilities and its confidence, showing that the highest probability
  (`0.87`) and the confidence (`0.80`) are different values.
- **B. Calibration bucket** — a fixed set of predictions in the
  `[0.75, 0.85)` bucket, whose average predicted probability and actual
  positive rate both equal `0.80` in this example.
- **C. Expected-loss review threshold** — a review threshold derived from
  `reviewCost / failureCost`, compared against a fixed event probability to
  produce a `review` or `skip` decision.
- **D. Score distribution** — the per-level probabilities behind a Score,
  the computed weighted result, and the high-risk-side (level 2) probability
  shown alongside the aggregate Score, since the two carry different
  information.

## Files

- `decision.ts`: the standalone sample source.

## Source / Attribution

This sample reproduces, as a self-contained TypeScript example, the
decision-logic approach described in:

- id774 article: <https://blog.id774.net/entry/2026/09/19/5693/>
- TypeSafe AI, "Introducing System 1 Models and Jev":
  <https://typesafe.ai/blog/introducing-system-one-models-and-jev>
- Cloudflare Workers AI, Jev documentation:
  <https://developers.cloudflare.com/ai/models/typesafe/jev/>

The choice probabilities/confidence values (A) and the Score/level
probabilities (D) are taken from Cloudflare's published Jev example. The
calibration (B) and expected-loss threshold (C) data are constructed for
this demonstration and are not drawn from Cloudflare's documentation.
