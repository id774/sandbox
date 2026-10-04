# Adapter Boundary

## Purpose

This is a standalone sample that demonstrates keeping external dependencies
behind interfaces and limiting the choice of execution mode to a single
composition root.

The application service, `RequestService`, depends only on three adapter
interfaces: `IdentityProvider`, `ObjectStorage`, and `Notifier`. It does not
receive or inspect the execution mode, and it does not refer to any concrete
adapter class.

The difference between the `local` and `cloud` modes is expressed only in the
composition root, `createRequestService()`, which is the one place that
branches on the mode and selects the local or cloud adapter implementations to
inject into the service.

The cloud adapters are demonstration stubs, just like the local adapters. They
only write to stdout and do not access any network service, cloud account,
credential, environment variable, or filesystem.

## Requirements

- Node.js 20 or later
- TypeScript 5.0 or later

No third-party package is required.

## Build / Run

```sh
tsc --target es2020 adapter_boundary.ts && node adapter_boundary.js
```

The sample takes no arguments and reads no input. The generated
`adapter_boundary.js` is build output and is not committed.

## Observable behavior

The sample runs the same request flow once in `local` mode and once in `cloud`
mode. In each mode, the identity, storage, and notification adapters report
that they were called, which shows which implementation the composition root
selected. The application-level result is `request-1` in both modes.

Expected stdout:

```text
local mode
identity: local demo-user
storage: local requests/request-1.json
notification: local request-1
result: request-1

cloud mode
identity: cloud demo-user
storage: cloud requests/request-1.json
notification: cloud request-1
result: request-1
```

`demo-user` and `request-1` are demonstration data. The only side effect is
stdout output, and the exit status is 0.

## Files

- `adapter_boundary.ts`: the standalone sample implementation.
