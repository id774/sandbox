# Jev Email Triage

## Purpose

This sample demonstrates converting a fixed email into a Jev-shaped `Choice`
category, a `Score` urgency, and a `Noul` human-written probability, with
deterministic code producing the displayed values.

## Self-contained / no live API call

This sample does not call Jev, access a mailbox, or use any other network
service. `judgeMail()` in `triage.ts` returns a fixed local Jev-shaped
response.

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
tsc --target es2020 triage.ts && node triage.js
```

The command generates a local `triage.js`; generated JavaScript is not committed
to the repository.

## Observable behavior

The fixed email is from `customer@example.invalid` with the subject
`Production API is failing` and the body `All requests have returned 500
since this morning. Please help today.`

The fixed response gives tray `needs_reply`, urgency score `4`, and
human-written probability `0.96`. The displayed urgency is
`Math.round(score) + 1`. A tray outside the finite set throws an error.

Expected stdout:

```text
tray: needs_reply
urgency: 5
human probability: 0.96
```

The process exits with status `0`.

## Files

- `triage.ts`: the standalone sample implementation.

## Source / Attribution

The decision boundary in this sample is an independent minimal implementation.
The following projects were used as design references only; no source code is
copied from them.

- TypeSafe AI JavaScript SDK:
  <https://github.com/typesafe-ai/typesafe-sdk-js>
- `fazlerocks/jevmail`: <https://github.com/fazlerocks/jevmail>
