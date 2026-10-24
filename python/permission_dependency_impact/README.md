# Permission and Dependency Impact

## Purpose

This standalone experiment compares two separate impact scopes in a fixed
fictional system: the resources for which a principal has `config:write`
permission and the business services affected by a mandatory dependency
failure. It tests permission restriction and identity-service separation as
different design changes, without treating resource or service counts as
observed incidents or risk estimates.

## Requirements

- Python 3.10 or later (verified with Python 3.13.5)
- Python standard library only
- Python assertions enabled (do not use `-O`)

## Run

From the repository root:

```sh
python3 -B python/permission_dependency_impact/verification.py
```

Expected standard output:

```text
Permission scope: 3 -> 1
Dependency scope: 4 -> 2
```

The script accepts no command-line arguments and reads no files. It uses
built-in fictional grants and dependencies, performs four set-equality
assertions, prints two summary lines, and exits with status 0 on success.
A failed assertion causes a nonzero exit status; it does not print the success
summary. The script makes no network requests or intentional file writes.

## Fixed scenarios

Before restriction, `ops-admin` can change `order-config`, `billing-config`,
and `report-config`. After restriction, it can change only `order-config`.
The `order-admin` and `billing-admin` grants remain unchanged.

Before separation, `orders` and `billing` require `identity-a`, `portal`
requires `orders`, and `reports` requires `billing`. After separation,
`billing` requires `identity-b`; all other existing dependencies remain.
`identity-a` and `identity-b` are assumed to have independent failure domains.
Business services are `orders`, `billing`, `portal`, and `reports`.

## Limits

A permission grant represents an effective authorization relationship rather
than an observed unauthorized action. Every listed dependency is mandatory,
with no fallback, cache-based continuation, or restoration within the modeled
interval. Counts describe reachable resources or affected services under those
assumptions, not breach probability, observed outages, impact duration, or risk.

## Files

- `verification.py`: fixed permission and dependency scenarios, reachability
  calculations, set assertions, and summary output.
