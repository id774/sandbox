# Authorization Acceptance Gate

## Purpose

This standalone Express experiment distinguishes an authorization fix from a
claim that the fix was made. A fixed route only returns a user's profile to
that user. A deliberately vulnerable comparison route skips the ownership
check. The same independent request checks accept or reject each variant.

## Requirements

- Node.js 22 or later and npm 10 or later
- Express 5.2.1 and Supertest 7.1.4 (installed locally using npm)
- Access to the public npm registry for the initial dependency installation
- No database, external authentication, external API, or credentials

## Run

From `js/authorization_acceptance_gate`:

```sh
npm ci
npm test
npm run test:reject
```

`npm test` prints `ACCEPT` and exits `0` after all four mandatory checks pass.
`npm run test:reject` prints `REJECT` and exits `1`, because the deliberately
vulnerable variant returns another user's profile. The nonzero status is the
expected result for this negative demonstration, not a successful gate.

## Acceptance Contract

| Request condition | Expected HTTP status | Protected email |
| --- | --- | --- |
| No authenticated user requests `alice` | 401 | Absent |
| `alice` requests `alice` | 200 | Only Alice's profile |
| `alice` requests `bob` | 403 | Absent |
| `unknown` requests `unknown`, which does not exist | 404 | Absent |

`verify.js` checks all four named cases, the exact owner response in the 200
case, and the absence of `email` in the other responses. A passing assertion
count alone is not treated as the acceptance contract: the four named cases
must also be present. Every request is sent through Supertest to the real
Express route, with an ephemeral local HTTP listener.

## Scope and Limits

Authentication is simulated by injecting a test-only identity when each app
is constructed. The sample does not authenticate HTTP credentials and must
not be deployed as an authentication or authorization service. Profiles use
fictional `.test` addresses held in memory. The vulnerable variant is present
only to demonstrate rejection of an ownership-check omission.

An `ACCEPT` result covers only the four checks defined here. It does not prove
that arbitrary APIs are secure, that a test suite cannot be altered, or that
an AI agent actually performed a particular repair. Dependency installation
may contact the public npm registry; test execution does not contact any
external service or alter application data.
