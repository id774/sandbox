# WebAuthn Validation

## Purpose

This standalone Python experiment separates ECDSA signature verification from
acceptance of an authentication request. It checks the relationship between a
registered credential, its owner, a challenge, an authentication request, and
the session whose state is updated. Twenty-one tests exercise the acceptance
conditions and verify state preservation on rejection.

## Requirements

- Python 3 interpreter and the standard library, including unittest
- cryptography 46.0.4, installed using the local requirements.txt
- Access to a package index or a local package cache for dependency installation

## Verified Environment

Tested with Python 3.13.5 and cryptography 46.0.4.

## Files

- `webauthn_validation.py`: in-memory registration and assertion validation model
- `test_webauthn_validation.py`: 21 unittest cases using generated keys and
  local assertion data
- `requirements.txt`: pinned direct dependency for reproducing the experiment

## Run

From the repository root:

```sh
cd python/webauthn_validation
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
python --version
python -m pip show cryptography
python -B -m unittest -v test_webauthn_validation
```

Use Python 3.13.5 to reproduce the verified environment. The `source` command
assumes a compatible shell. All 21 tests must pass with `OK` and exit status 0.
An assertion failure or uncaught test error produces a nonzero exit status.
The reported elapsed time is environment-dependent.

## Validation contract

The model uses `example.com` as RP ID, `https://login.example.com` as Origin,
32-byte random challenges, a 300-second lifetime, ECDSA P-256 with SHA-256,
and required UP and UV flags. A request is tied to one account and one
session. The signature covers the authenticator data followed by the SHA-256
hash of the original client data bytes. The fixture uses 37-byte authenticator
data with a zero signature counter and no extensions or attested data.

Registration accepts only a previously authorized account and matching
verified owner, a nonempty new credential ID, and a P-256 public key. The
registration inputs are trusted outputs of a completed registration ceremony.
Authentication checks the credential, signature, active state, request,
owner, session, challenge lifetime and usage, client data, operation type,
Origin, RP ID hash, and flags. The successful transition consumes the request
and associates its session with the account inside one lock. Rejections in
the tests preserve all three state dictionaries. The trusted revocation method
marks a credential inactive. `begin` raises `ValueError('session')` for a
missing or already authenticated session. The model exposes Python methods,
not a network endpoint or separate command-line application.

| ID | Case | Expected result |
| --- | --- | --- |
| V01 | Authorized registration | Registered with owner alice |
| V02 | Valid assertion | accepted, used=True, session alice |
| V03 | Wrong registration authorization | Registration rejected, state unchanged |
| V04 | Duplicate credential ID | Registration rejected, state unchanged |
| V05 | Public key overwrite | Registration rejected, state unchanged |
| V06 | Wrong verified registration owner | Registration rejected, state unchanged |
| V07 | Invalid signature | signature, state unchanged |
| V08 | Unknown credential ID | credential, state unchanged |
| V09 | Wrong credential owner | owner, state unchanged |
| V10 | Revoked credential | credential, state unchanged |
| V11 | Wrong challenge | challenge, state unchanged |
| V12 | Challenge at expiry boundary | challenge, state unchanged |
| V13 | Reuse after successful authentication | challenge, state unchanged |
| V14 | Wrong Origin | origin, state unchanged |
| V15 | Wrong RP ID hash | rp, state unchanged |
| V16 | Missing UP | up, state unchanged |
| V17 | Missing UV | uv, state unchanged |
| V18 | Wrong operation type | type, state unchanged |
| V19 | Wrong session | session, state unchanged |
| V20 | Failure followed by valid assertion | signature, state unchanged, then accepted |
| V21 | Two concurrent submissions with observed lock contention | One accepted and one challenge; session alice |

V09–V19 use valid signatures verified independently before rejection. V08
has no registered public key for the supplied ID. V13 checks the detection
of a consumed challenge in a session that is already authenticated. It does
not isolate the effect of removing the challenge-use check. V21 pauses the
first thread immediately before the authentication state update and observes
the second thread's failed non-blocking acquisition of the original lock.
The first thread then completes, and the second rejects the consumed
challenge. The test verifies observed lock contention and the final state
under this controlled schedule.

## Scope and limits

This is a test model for account-first authentication, not a complete or
production-ready WebAuthn implementation. It does not validate registration
attestation, implement browser or authenticator communication, parse arbitrary
authenticator data, evaluate signature counter changes, handle backup flags,
verify discoverable-credential user handles, manage HTTP cookies or session
rotation, or provide persistent or distributed transaction guarantees.
The tests exercise only the stated cases, not general WebAuthn conformance
or security. The keys and identities are created solely for local tests;
no real credentials, private keys, external services, or network listeners
are needed. Test execution makes no network requests. Dependency installation
may require network access.
