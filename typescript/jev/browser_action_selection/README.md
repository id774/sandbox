# Jev Browser Action Selection

## Purpose

This sample demonstrates a browser automation boundary in which the model
does not generate selectors or executable code. Ordinary code prepares the
observed targets, a Jev-shaped `Choice` selects one target ID, and ordinary
code performs the side effect.

## Self-contained / no live API call

This sample does not call Jev, launch a browser, or access any network
service. Playwright or any other browser driver is not required. The observed
targets and the executor are simulated locally, and `chooseTarget()` in
`select_action.ts` returns a fixed local Jev-shaped `Choice`.

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
tsc --target es2020 select_action.ts && node select_action.js
```

The command generates a local `select_action.js`; generated JavaScript is not committed
to the repository.

## Observable behavior

The fixed task is `Save the settings.` The observed target IDs are `save`,
`cancel`, and `done`, and the fixed choice is `save`. The deterministic
executor maps `save` to `save`, `cancel` to `cancel`, and `done` to
`none`. A choice outside the finite target set throws an error.

Expected stdout:

```text
selected action: save
executed action: save
```

The process exits with status `0`.

## Files

- `select_action.ts`: the standalone sample implementation.

## Source / Attribution

The decision boundary in this sample is an independent minimal implementation.
The following projects were used as design references only; no source code is
copied from them.

- TypeSafe AI JavaScript SDK:
  <https://github.com/typesafe-ai/typesafe-sdk-js>
- `tontoko/jev-browser`: <https://github.com/tontoko/jev-browser>
