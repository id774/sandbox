# Jev Semantic Lint

## Purpose

This sample demonstrates semantic linting of a TypeScript function. The check
is split into narrow Jev-shaped `Noul` judgments for individual defects and a
`Score` for severity, and a deterministic CI policy decides whether the check
fails.

## Self-contained / no live API call

This sample does not call Jev or any other network service. `judgeSource()` in
`lint.ts` returns a fixed local Jev-shaped response.

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
tsc --target es2020 lint.ts && node lint.js
```

The command generates a local `lint.js`; generated JavaScript is not committed
to the repository.

## Observable behavior

The fixed source text is:

```ts
function canCheckout(user: User | null) {
    if (user) return false;
    return user.balance > 0;
}
```

The fixed response gives `inverted_condition` `0.92`, `unhandled_null`
`0.99`, and severity score `2.8`. An issue is reported when its probability
is `>= 0.8`. The check fails when at least one issue is reported or the
severity is `>= 2.5`.

Expected stdout:

```text
issues: inverted_condition, unhandled_null
severity: 2.8
```

After printing the stdout above, the process sets `process.exitCode = 1` and
exits with status `1`. This is the expected behavior of the sample, because
detecting the defects in the fixed fixture is its purpose.

## Files

- `lint.ts`: the standalone sample implementation.

## Source / Attribution

The decision boundary in this sample is an independent minimal implementation.
The following projects were used as design references only; no source code is
copied from them.

- TypeSafe AI JavaScript SDK:
  <https://github.com/typesafe-ai/typesafe-sdk-js>
- `lakeday-org/perch`: <https://github.com/lakeday-org/perch>
