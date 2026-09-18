# Jev Decision Logic

## Purpose

Jev is TypeSafe AI's typed probabilistic model, served on Cloudflare Workers
AI, which returns structured outputs such as `Noul`, `Choice`, and `Score`
answers instead of free-form text. This sample connects that typed output to
ordinary business logic through the full set of patterns covered in the
companion article: an API-shaped request and response, the distinction
between probability and confidence, calibration against observed outcomes,
expected-loss review thresholds, business branches driven by those
thresholds, audit records, comparing Score distributions with the same
aggregate value, and an operational log record.

## Self-contained / no live API call

This sample does not call the Jev API, Cloudflare Workers AI, or any other
network service. `env.AI.run()` is a local mock defined in `decision.ts`
that returns fixed data; it is not a live Cloudflare Workers AI call. All
data is fixed inside `decision.ts`. It requires no API token, account ID, or
other credential, and performs no network access.

## Requirements

- `tsc` (TypeScript compiler)
- `node` (JavaScript runtime)

No third-party package is required.

## Build / Run

```sh
tsc --target es2020 decision.ts && node decision.js
```

## Observable output

Running the sample prints nine sections to stdout:

- **A. Jev-shaped request and response** — an `env.AI.run()` call using the
  same request shape as the live API, resolved by a local mock into a typed
  `Noul` / `Choice` / `Score` response.
- **B. Probability vs. confidence** — the `Choice` answer's highest
  probability (`0.87`) and its `confidence` (`0.80`), showing that
  `Math.max(...Object.values(probabilities))` is not the same value as
  `confidence`.
- **C. Calibration bucket [0.75, 0.85)** — a fixed set of predictions in that
  bucket, whose average predicted probability and actual positive rate both
  equal `0.80` in this example.
- **D. Expected-loss fraud review** — a review threshold derived from
  `reviewCost / failureCost`, compared against a fixed fraud probability to
  choose between `sendToHumanReview()` and `approve()`.
- **E. Noul escalation decision** — the same threshold logic applied to a
  `Noul` `escalate` answer, choosing between `sendToHumanReview()` and
  `continueAutomatedFlow()`.
- **F. Choice audit record** — the `Choice` answer's `choice`,
  `probabilities`, and `confidence` captured in an audit record alongside a
  not-yet-known `actualDepartment`.
- **G. Score distribution** — the `Score` answer's per-level probabilities,
  the computed weighted result, its `confidence`, and the high-risk-side
  (level 2) probability shown alongside the aggregate Score.
- **H. Same score, different distributions** — two distributions with the
  same weighted score (`1.00`), where a `score > 1.5` check and a
  `probabilities["2"] > 0.3` check produce different review decisions.
- **I. Operational log record** — a record carrying the operational log
  fields named in the article: `model_version`, `question_type`,
  `prediction`, `probability`, `probabilities`, `confidence`, `threshold`,
  `decision`, and `actual_result`.

## Qiita code coverage

This sample was expanded so that every code example in the companion Qiita
article has a corresponding path in `decision.ts`. The article's Python
calibration example is ported to TypeScript, as `calibrationByBucket()`,
because this directory is the TypeScript sandbox sample.

| Qiita code example | `decision.ts` |
| --- | --- |
| `env.AI.run("typesafe/jev", ...)` request | mock `env.AI.run()` call in section A |
| Jev response JSON (`Noul` / `Choice` / `Score`) | `supportResponse` |
| probability vs. confidence distinction | section B |
| calibration (Python) example | `calibrationByBucket()` (section C) |
| `shouldReview()` | `shouldReview()`, same name and behavior |
| fraud review `if` branch | section D |
| Noul escalation `if` branch | section E |
| `Choice` extraction and audit record | section F |
| Score / `probabilities` | section G |
| distributions A / B with the same score | section H |
| `score > 1.5` vs. level 2 probability branch | section H |
| production log fields | section I |

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

The `model`, `is_urgent`, `department`, and `frustration` values in
`supportResponse` are taken from Cloudflare's published Jev example. The
calibration, expected-loss threshold, escalation, and distribution-A/B data
are constructed for this demonstration and are not drawn from Cloudflare's
documentation. The published example's Score matches the weighted result
computed here; this is a demonstration on that example, not a claim that
Cloudflare defines Score as an expected value in general.
