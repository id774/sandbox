# LLVM IR

## Overview

LLVM IR is the intermediate representation at the core of the LLVM compiler infrastructure project, a form that source programs are translated into once a compiler's frontend has parsed and analyzed them, and from which the infrastructure's optimizers and backends work. Rather than being tied to any single source language or target processor, LLVM IR is a strongly typed, low-level representation that can express the constructs of many different programming languages while remaining independent of any particular machine's instruction set, which is what allows the same optimization and code-generation machinery to serve a wide variety of languages and hardware targets.

## History

LLVM originated as a research project at the University of Illinois at Urbana-Champaign, begun around 2000 by Chris Lattner, then a graduate student, working under the supervision of professor Vikram Adve. The project set out to investigate techniques for optimizing programs both statically at compile time and dynamically at run time, and its design, including the intermediate representation at its center, formed the basis of Lattner's 2002 master's thesis. LLVM's approach to compiler construction, built around this shared intermediate representation, proved influential enough that Adve, Lattner, and later contributor Evan Cheng received the Association for Computing Machinery's Software System Award in 2012 for designing and implementing it.

## Architecture and characteristics

LLVM IR is built around static single-assignment (SSA) form, a discipline under which each variable in the representation is assigned a value exactly once, a property that considerably simplifies many of the data-flow analyses and optimizations compilers perform. The representation is also explicitly typed, so that the operations available on a value are constrained by its declared type, which helps optimization passes reason about a program's behavior safely. LLVM defines three interchangeable forms of this representation: a human-readable textual assembly form used for inspecting and debugging IR, an in-memory form that compiler frontends and passes construct and manipulate directly, and a compact binary encoding known as bitcode, used for storing or transmitting IR efficiently. Because frontends, optimization passes, and backends all operate on this same representation, a compiler frontend for a given source language only needs to translate that language into LLVM IR once, after which any of LLVM's optimization passes and any of its supported target backends can be applied without further changes tied to the original source language.

## Ecosystem and use

Clang, a frontend for the C, C++, and Objective-C family of languages, is the most prominent consumer of LLVM IR, translating source code into the representation after performing its own parsing and semantic analysis, but it is far from the only one: compilers and toolchains for languages including Rust, Swift, Julia, Kotlin, and Haskell, among many others, generate LLVM IR as a step toward native code, relying on LLVM's shared optimizers and its backends for architectures such as x86, ARM, PowerPC, and WebAssembly rather than implementing that machinery themselves. LLVM IR can be turned into machine code at several different points in a program's lifecycle: ahead of time, as part of an ordinary compile step or, with additional interprocedural optimization, at link time across whole programs; or at run time, through LLVM's just-in-time compilation engine, which language implementations that generate and execute code dynamically rely on.

## References

- [Wikipedia: LLVM](https://en.wikipedia.org/wiki/LLVM)
