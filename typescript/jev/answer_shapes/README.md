# Jev Answer Shapes

## Purpose

This sample demonstrates choosing among Jev `Choice`, `Score`, and `Noul`
questions by the answer shape that downstream code needs.

- `Choice` returns a finite unordered label, which is validated into an
  application-domain union and consumed by a `switch`.
- `Score` returns an ordered scale, which is consumed by a numeric comparison.
- `Noul` returns a proposition probability, which is consumed by a probability
  threshold.

The three questions are asked about the same support state in one Jev-shaped
request.

## Self-contained / no live API call

This sample does not call the live Jev API, Cloudflare Workers AI, or any other
network service. `env.AI.run()` in `answer_shapes.ts` is a local mock that
returns a fixed Jev-shaped response.

No API key, token, account ID, environment variable, or other credential is
required.

The fixed response is demonstration data and must not be interpreted as a live
model result.

## Requirements

- `tsc` (TypeScript compiler)
- `node` (JavaScript runtime)

No third-party package is required.

## Build / Run

```sh
tsc --target es2020 answer_shapes.ts && node answer_shapes.js
```

The command generates a local `answer_shapes.js`; generated JavaScript is not
committed to the repository.

## Observable behavior

The fixed support state has the subject `Production API failure` and the
message `Requests have returned 500 since this morning. Please investigate
today.`

The fixed response gives handler `technical`, urgency score `2.4`, and human
review probability `0.78`. The handler is routed to `/queues/technical`, the
score is expedited at `2` or above, and human review is required at `0.70` or
above. A handler outside the finite set throws an error.

Expected stdout:

```text
handler: technical
queue: /queues/technical
urgency score: 2.4
expedited: true
human review probability: 0.78
human review: true
Jev calls: 1
```

The process exits with status `0`.

## Answer shapes

| Answer shape | Jev type | Downstream use |
| --- | --- | --- |
| Finite unordered label | `Choice` | validated union + `switch` |
| Ordered scale | `Score` | numeric comparison |
| Proposition probability | `Noul` | probability threshold |

## Files

- `answer_shapes.ts`: standalone sample implementation.

## Source / Attribution

This sample is a repository-owned minimal implementation. The following
TypeSafe AI documents are its technical references.

- TypeSafe AI, `Primitives (Questions)`: <https://docs.typesafe.ai/primitives>
- TypeSafe AI, `JavaScript SDK`: <https://docs.typesafe.ai/sdk/javascript>
