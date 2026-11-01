# Lemma Dependency in Lean 4

## Purpose

This experiment reproduces the effect of weakening a lemma from `x = y` to
`x ≤ y` while retaining the downstream goal `y ≤ z`. The original proof can
rewrite by equality; the weakened inequality cannot justify that rewrite.
A concrete natural-number counterexample refutes the weakened universal
statement, and a reverse inequality supplies the missing condition for a
repaired proof.

## Requirements

- `elan` and Lean 4.35.0 (`leanprover/lean4:v4.35.0`)
- macOS or Linux shell for the documented commands
- No Mathlib, Lake project, additional Lean packages, fixtures, network calls
  from the examples, elevated privileges, or input files

Install the specified toolchain if it is not installed:

```sh
elan toolchain install leanprover/lean4:v4.35.0
lean +leanprover/lean4:v4.35.0 --version
```

The version output must contain `4.35.0`.

## Files and expected behavior

| File | Expected result | Property checked |
| --- | --- | --- |
| `Before.lean` | Successful Lean exit | `x = y` and `x ≤ z` imply `y ≤ z` by rewriting |
| `After.lean` | Nonzero Lean exit, by design | `rw [← hLE]` attempts equality rewriting using `hLE : x ≤ y` |
| `Counterexample.lean` | Successful Lean exit | `x = 1`, `y = 3`, `z = 2` satisfy the weakened hypotheses but refute `y ≤ z` |
| `Repaired.lean` | Successful Lean exit | Adding `y ≤ x` permits `Nat.le_antisymm` and restores the downstream conclusion |

## Run and inspect

Run each file independently from this directory:

```sh
lean +leanprover/lean4:v4.35.0 Before.lean
lean +leanprover/lean4:v4.35.0 After.lean
lean +leanprover/lean4:v4.35.0 Counterexample.lean
lean +leanprover/lean4:v4.35.0 Repaired.lean
```

The second command is an intentional rejection, not a successful proof.
Confirm that its diagnostic is located at `rw [← hLE]` and concerns the
attempt to rewrite by an inequality. Another failure, such as a parse error,
missing toolchain, or unrecognized identifier, does not satisfy the expected
result. A nonzero exit status by itself is insufficient.

`Before.lean`, `Counterexample.lean`, and `Repaired.lean` must succeed and must
not introduce `sorry` or additional axioms. `#check` prints theorem types and
`#print axioms` prints transitive axiom dependencies where present.

The repaired theorem adds `hYX : y ≤ x`; it can be used only where that
additional hypothesis is proved. These files model a dependency of proofs
over natural numbers, not the classification of finite simple groups.
