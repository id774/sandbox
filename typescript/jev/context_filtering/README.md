# Jev Context Filtering

## Purpose

This sample demonstrates narrowing already retrieved candidate context with
Jev-shaped `Noul` relevance, so that deterministic code chooses what is passed
to a later model or process.

## Self-contained / no live API call

This sample does not call Jev or any other network service, and it does not
retrieve context itself. `judgeRelevance()` in `filter_context.ts` returns
fixed local Jev-shaped `Noul` values.

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
tsc --target es2020 filter_context.ts && node filter_context.js
```

The command generates a local `filter_context.js`; generated JavaScript is not committed
to the repository.

## Observable behavior

The fixed query is `Investigate retry handling after authentication
failures.` The candidates are:

- `auth`: `src/auth/retry.ts: retry handling for 401 and 429`
- `ui`: `src/ui/theme.ts: dark mode colors`
- `billing`: `src/billing/invoice.ts: invoice generation`

Their fixed relevance is `0.96`, `0.05`, and `0.12`. Candidates with
relevance `>= 0.7` are selected, so only `auth` is passed on.

Expected stdout:

```text
query: Investigate retry handling after authentication failures.
threshold: 0.7
selected context: auth
```

The process exits with status `0`.

## Files

- `filter_context.ts`: the standalone sample implementation.

## Source / Attribution

The decision boundary in this sample is an independent minimal implementation.
The following projects were used as design references only; no source code is
copied from them.

- TypeSafe AI JavaScript SDK:
  <https://github.com/typesafe-ai/typesafe-sdk-js>
- `kbhuw/jev-sift`: <https://github.com/kbhuw/jev-sift>
