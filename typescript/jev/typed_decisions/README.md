# Jev Typed Decisions

## Purpose

This is a self-contained sample implementation that demonstrates how to place
Jev's typed decisions at the boundary between unstructured input and ordinary
TypeScript business logic. It uses Jev's `Noul`, `Choice`, and `Score`
decisions at that boundary.

The implementation keeps deterministic rules in code, sends semantic judgment
to a Jev-shaped interface, validates a `Choice` result at the application
boundary, and then routes the validated value through an ordinary TypeScript
union type and `switch` statement.

## Self-contained / no live API call

This sample does not call Jev, Cloudflare Workers AI, or any other network
service. `env.AI.run()` in `decision.ts` is a local mock that returns fixed
`Noul`, `Choice`, and `Score` data. No API token, account ID, environment
variable, or other credential is required.

The fixed response is demonstration data. It illustrates the API shape used by
the sample and must not be interpreted as a current live model result.

## Requirements

- `tsc` (TypeScript compiler)
- `node` (JavaScript runtime)

No third-party package is required.

## Build / Run

```sh
tsc --target es2020 decision.ts && node decision.js
```

## Observable behavior

The sample processes two support states.

For an unlocked account, the request reaches the local Jev mock. The
`department` `Choice` is validated as a `Department`, then ordinary TypeScript
business logic routes `account` to `/queues/account`.

For a locked account, the deterministic `account.locked` rule routes directly
to `/queues/security` before `env.AI.run()` is called. The final call count is
therefore one even though two states are processed.

Expected stdout:

```text
Unlocked account
  decision source: jev
  department: account
  queue: /queues/account

Locked account
  decision source: rule
  queue: /queues/security

Jev calls: 1
```

## Implementation coverage

| Concept | Implementation |
| --- | --- |
| `Noul`, `Choice`, and `Score` | `NoulAnswer`, `ChoiceAnswer`, `ScoreAnswer`, `questions`, and `supportResponse` |
| `state` and `questions` separation | `SupportState` and the separate `questions` constant |
| `Choice` as a finite application domain | `departments` and `Department` |
| Validate the model boundary | `isDepartment()` rejects values outside `Department` |
| Connect a typed decision to business logic | `routeDepartment()` uses an exhaustive `switch` over `Department` |
| Keep deterministic rules in code | `routeSupportRequest()` handles `account.locked` before the Jev call |
| Semantic judgment through Jev | unlocked requests call `env.AI.run()` and use the returned `department` choice |
| Verify the deterministic bypass | `jevCallCount` shows that the locked request did not invoke the model mock |

This sample intentionally implements only the Jev-side application boundary
and does not add a second model or JSON Mode dependency.

## Files

- `decision.ts`: the standalone sample implementation.

## Source / Attribution

The Jev API shape and terminology used by this sample are based on:

- TypeSafe AI, "Introducing System One Models & Jev":
  <https://typesafe.ai/blog/introducing-system-one-models-and-jev>
- Cloudflare Workers AI, Jev documentation:
  <https://developers.cloudflare.com/ai/models/typesafe/jev/>
