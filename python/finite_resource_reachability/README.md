# Finite Resource Reachability

## Purpose

This standalone Python example checks numerical and illustrative proof-system
examples from the Zenn article [Computable Algorithms and Finite Resources](https://zenn.dev/id774/articles/c09d4a19a8de92).
It distinguishes an algorithm's mathematical description from the resources
needed to carry out a particular finite computation.

## Requirements

- Python 3.12 or later
- Python standard library only

## Run

From the repository root:

```sh
python3 -B python/finite_resource_reachability/finite_resource_reachability.py
```

A successful run ends with `All finite-resource example checks: PASS` and exit
status 0. A failed check raises `AssertionError` and exits nonzero.
No command-line arguments, network access, elevated privileges, or external
input files are required. The script does not write files.

## What Is Checked

- A 256-bit key space contains `2**256` candidates. At an *assumed* rate of
  `10**12` attempts per second, the worst case takes approximately
  `3.672e+57` years and one year covers approximately `2.724e-58` of the space.
  The script independently exhausts an 8-bit equality-oracle model, confirming
  256 attempts in the worst case and 128.5 attempts on average.
- The full binary representation of `2**(2**100)` requires exactly
  `1267650600228229401496703205377` bits or
  `158456325028528675187087900673` packed bytes. The script checks the
  formula against small integers and calculates the minimum output time at an
  *assumed* throughput of `10**12` bytes per second.
- A deliberately simple proof system has axiom `P(0)` and the inference rule
  `P(i) -> P(i+1)`. The script generates and verifies sequences ending at
  `P(100)`, `P(1000)`, and `P(10000)` and rejects a corrupted or empty sequence.

A year is defined as exactly 365 days for the numerical estimates.

## Limitations

The search is not an AES implementation or hardware benchmark. The script
neither exhausts a 256-bit key space nor constructs the enormous integer.
The illustrative proof system does not establish general proof-complexity
results. These finite demonstrations cannot prove universal computability,
termination, or complexity bounds.
