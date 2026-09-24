# Jev Home Automation

## Purpose

This sample demonstrates passing a sensor state to a Jev-shaped `Noul`
judgment and letting a deterministic automation policy create a notification
decision.

## Self-contained / no live API call

This sample does not call Jev, connect to a home automation server, operate
any device, or access any network service. The sensor state is fixed, and
`judgeLaundryForgotten()` in `automation.ts` returns a fixed local
Jev-shaped `Noul`.

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
tsc --target es2020 automation.ts && node automation.js
```

The command generates a local `automation.js`; generated JavaScript is not committed
to the repository.

## Observable behavior

The fixed washing machine power is `3` watts, and the fixed laundry-forgotten
probability is `0.88`. The policy notifies when the probability is `>= 0.7`.
The notification decision is only printed; no notification is sent.

Expected stdout:

```text
power watts: 3
laundry forgotten: 0.88
notify: true
```

The process exits with status `0`.

## Files

- `automation.ts`: the standalone sample implementation.

## Source / Attribution

The decision boundary in this sample is an independent minimal implementation.
The following projects were used as design references only; no source code is
copied from them.

- TypeSafe AI JavaScript SDK:
  <https://github.com/typesafe-ai/typesafe-sdk-js>
- `AboveColin/HA-Jev`: <https://github.com/AboveColin/HA-Jev>
