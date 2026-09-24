# Jev MCP Decisions

## Purpose

This sample demonstrates calling Jev as an MCP-style external decision tool
instead of embedding it directly in the application, then validating the
finite route result at the application boundary.

## Self-contained / no live API call

This sample does not call Jev, start an MCP server or any external process,
or access any network service. `callTool()` in `route.ts` is a local mock
that returns a fixed MCP tool response.

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
tsc --target es2020 route.ts && node route.js
```

The command generates a local `route.js`; generated JavaScript is not committed
to the repository.

## Observable behavior

The fixed MCP request calls the `jev_route` tool with the task `Write a 2000
word essay with careful reasoning.` and two candidates:

- `fast`: `Cheap quick model for simple lookups`
- `deep`: `Strong model for long careful reasoning`

The fixed response gives route `deep` with confidence `0.93`. The allowed
routes are `fast` and `deep`; a route outside that finite set throws an
error.

Expected stdout:

```text
tool: jev_route
route: deep
confidence: 0.93
```

The process exits with status `0`.

## Files

- `route.ts`: the standalone sample implementation.

## Source / Attribution

The decision boundary in this sample is an independent minimal implementation.
The following projects were used as design references only; no source code is
copied from them.

- TypeSafe AI JavaScript SDK:
  <https://github.com/typesafe-ai/typesafe-sdk-js>
- `jkudish/jev-mcp`: <https://github.com/jkudish/jev-mcp>
- `walidboulanouar/jev-agent-kit`:
  <https://github.com/walidboulanouar/jev-agent-kit>
