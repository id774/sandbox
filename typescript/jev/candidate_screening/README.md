# Jev Candidate Screening

## Purpose

This sample demonstrates screening a fixed profile fixture against required
criteria. Jev-shaped `Choice` answers select the status of each criterion and
one evidence excerpt ID from finite sets, and deterministic code builds the
`potential_match` state.

`potential_match` is a state for extracting candidates for human review. It
is not a hiring decision.

## Self-contained / no live API call

This sample does not call Jev or any other network service, and it does not
access any live profile. The profile is a fictional fixture, and
`judgeProfile()` in `screen_candidate.ts` returns a fixed local Jev-shaped
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
tsc --target es2020 screen_candidate.ts && node screen_candidate.js
```

The command generates a local `screen_candidate.js`; generated JavaScript is not committed
to the repository.

## Observable behavior

The fixed profile has the title `Solutions Engineer` and these excerpts:

- `e0`: `Tokyo, Japan`
- `e1`: `Solutions Engineer at Example Corp`
- `e2`: `Built customer-facing integrations and deployment tooling`

The fixed choices are role `met`, location `met`, and evidence `e2`.
`potential_match` is true when role is `met`, location is `met`, and
evidence is not `none`. A choice outside its finite set throws an error.

Expected stdout:

```text
potential match: true
evidence: e2
```

The process exits with status `0`.

## Files

- `screen_candidate.ts`: the standalone sample implementation.

## Source / Attribution

The decision boundary in this sample is an independent minimal implementation.
The following projects were used as design references only; no source code is
copied from them.

- TypeSafe AI JavaScript SDK:
  <https://github.com/typesafe-ai/typesafe-sdk-js>
- `skeptrunedev/jev-recruiter`: <https://github.com/skeptrunedev/jev-recruiter>
