# Lean

## Overview

Lean is an interactive theorem prover and functional programming language based
on dependent type theory. It is designed for formalizing mathematics and for
formal verification, while also supporting ordinary functional programming and
metaprogramming.

## History

The Lean project was launched by Leonardo de Moura at Microsoft Research in
2013. Lean 0.1 was released in 2014, Lean 3 followed in 2017, and Lean 4 became
the current major implementation. Lean 4 is largely self-hosted and combines a
small trusted kernel with an extensible elaborator and tactic system.

## Language design and characteristics

Lean represents propositions as types and proofs as terms inhabiting those
types. User-facing syntax and tactics are elaborated into Lean's core type
theory, and the trusted kernel checks the resulting terms. This separation
allows powerful automation without making the automation itself part of the
trusted proof-checking core.

Lean also functions as a programming language. It supports algebraic data
types, pattern matching, type classes, dependent types, macros, and
metaprogramming in Lean itself.

## Implementation and ecosystem

Lean 4 is developed as an open-source project. The language implementation is
largely written in Lean, with a small kernel responsible for checking proof
terms. The `elan` tool is commonly used to install and select Lean toolchains,
and Lake is Lean's build system and package manager. Mathlib is the major
community library for formalized mathematics, although the examples in this
directory use only Lean itself and do not depend on Mathlib.

## Installation

Lean is normally installed through the `elan` toolchain manager.

### Debian

```sh
sudo apt update
sudo apt install elan
elan default stable
lean --version
```

### macOS

```sh
brew install elan-init
elan default stable
lean --version
```

Individual source files may record the Lean version used to validate that
specific example.

## Uses and influence

Lean is used for interactive theorem proving, formalized mathematics, software
and hardware verification, verified algorithms, and research on automated and
AI-assisted theorem proving. Its combination of an expressive language,
automation, and a small proof-checking kernel makes it useful for experiments
that separate proof generation from proof validation.

## References

- [Lean](https://lean-lang.org/)
- [The Lean Language Reference](https://lean-lang.org/doc/reference/latest/)
- [Theorem Proving in Lean 4](https://lean-lang.org/theorem_proving_in_lean4/)

## Layout

These standalone examples use only Lean itself and do not depend on Mathlib.
Each source file records the Lean version used for that sample's validation.

- `finite_examples.lean`: proves three concrete `Nat` addition examples with
  `rfl`.
- `universal.lean`: proves `n + 0 = n` for every `Nat` and prints its axiom
  dependencies.
- `invalid.lean`: intentionally attempts to prove the false statement
  `n + 1 = n` with `rfl`; Lean is expected to reject it.
- `sorry_example.lean`: intentionally uses `sorry` to admit the same false
  statement and prints the resulting `sorryAx` dependency.

Run the positive examples from this directory with:

```sh
lean finite_examples.lean
lean universal.lean
```

Run the two validation-boundary examples separately:

```sh
lean invalid.lean
lean sorry_example.lean
```

`invalid.lean` is expected to fail. `sorry_example.lean` is expected to be
processed with a warning about `sorry`, and its printed axiom dependencies are
expected to include `sorryAx`.
