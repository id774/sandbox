# Nim

## Overview

Nim is a general-purpose, multi-paradigm programming language that is statically typed and compiled, while presenting a syntax that reads more like a dynamic scripting language than a typical systems language. It combines compile-time type checking and type inference with an indentation-based syntax reminiscent of Python, and it places heavy emphasis on compile-time metaprogramming as a way of extending the language itself. The project describes its own goals as producing code that is efficient, expressive, and easy to read, and it targets both systems-level and general application development.

## History

Nim was designed and originally implemented by Andreas Rumpf, who began work on the language in 2005 under the name Nimrod and made it publicly available in 2008. The language was renamed from Nimrod to Nim with the release of version 0.10.2 in December 2014, adopting the shorter name it has used since. Development has continued as an open, community-supported project, with the compiler and standard library evolving through successive numbered releases, including the arrival of Nim 2.0, which changed some of the language's default runtime behavior.

## Language design and characteristics

Nim is statically typed and relies on type inference to reduce the need for explicit type annotations, while its block structure is defined through indentation and the offside rule in a manner visibly influenced by Python, even though the underlying language is a distinctly different, compiled, statically typed design rather than a dynamic one. It supports multiple programming paradigms, including procedural, object-oriented, functional, and message-passing styles. A central feature of Nim is its compile-time metaprogramming system, which includes syntactic macros and term-rewriting macros; the latter allow library authors to implement facilities such as big-number arithmetic or matrix types that integrate syntactically as though they were built into the language, rather than requiring special compiler support. Nim also supports algebraic data types and compile-time code generation as part of this same metaprogramming toolkit.

Memory management in Nim is handled through a set of tunable strategies rather than a single fixed garbage collector: options range from tracing garbage collection to reference counting to fully manual memory management. The current default strategy is a deterministic, automatic reference-counting scheme with move-semantics optimizations (ARC), which can be extended with a cycle collector based on trial deletion (ORC) to reclaim reference cycles that plain reference counting cannot; as of Nim 2.0, this ORC mode is the default memory manager.

## Implementation and ecosystem

The Nim compiler is self-hosting, meaning it is itself written in Nim. Rather than producing machine code directly for every platform, the compiler by default translates Nim source into C, which is then handed to an external C compiler for final compilation and optimization; it also supports compiling to C++, Objective-C, and JavaScript as alternative intermediate targets, which lets Nim programs run in environments such as web browsers or interoperate directly with codebases written in those languages. A foreign function interface allows Nim code to call into, and be called from, C, C++, Objective-C, and JavaScript, giving Nim programs direct access to existing native libraries and platform APIs rather than requiring bindings to be maintained through a separate abstraction layer.

## Uses and influence

Nim's combination of static typing, compilation to efficient native or C-based targets, and direct interoperability with existing C and C++ code positions it as a language for both systems programming and general application development, letting a single codebase target multiple platforms through its choice of compilation backend. Its design has drawn attention within the programming-language community for pairing a readable, whitespace-sensitive syntax with a compiled, statically typed implementation and an unusually extensive compile-time metaprogramming facility.

## References

- [Wikipedia: Nim (programming language)](https://en.wikipedia.org/wiki/Nim_(programming_language))

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
