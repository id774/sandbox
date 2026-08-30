# Scheme (Gauche)

## Overview

Scheme is a dialect of Lisp: a family of programming languages that represent both code and data as nested lists and that trace back to the original Lisp language. Scheme in particular is known for a deliberately minimalist design, favoring a small set of core constructs from which more elaborate features can be built, rather than a large fixed set of built-in special forms. Gauche is not a language distinct from Scheme; it is one specific implementation of Scheme, and the distinction matters because the two names describe different things: Scheme is the language, and Gauche is a particular program that runs Scheme code, built with a particular purpose in mind.

## History

Scheme was created in the 1970s at the MIT Artificial Intelligence Laboratory by Guy L. Steele and Gerald Jay Sussman. It grew out of their effort to build a small interpreter to understand the semantics of Carl Hewitt's actor model of computation in terms of the lambda calculus, and the resulting design was documented in a series of internal memos. Scheme was notable as the first Lisp dialect to adopt lexical scoping and the first to require implementations to properly support tail calls. Since then, Scheme has been standardized through a series of documents conventionally called the "Revised Report on Scheme," with each further revision named by adding another "Revised" to the title, leading to standards commonly abbreviated as R5RS, R6RS, and R7RS, in addition to a formal IEEE standard. Gauche's own history is separate and much more recent: it is primarily developed by Shiro Kawai and was first released in the early 2000s as a Scheme implementation aimed at practical scripting rather than at language research.

## Language and implementation characteristics

As a language, Scheme is built around lexical scope, meaning a variable's binding is determined by where it appears in the program's text; first-class procedures, meaning functions can be passed around, returned, and stored just like any other value; and proper tail calls, meaning a function call in tail position does not grow the call stack, which allows recursion to be used as a general looping construct. Scheme's core is intentionally small, with more convenient constructs typically defined as derived forms built on top of a handful of primitives, and the language provides a hygienic macro system for extending its own syntax as well as first-class continuations, which capture the rest of a computation as a value that can be invoked later. Gauche, as an implementation, targets the R7RS standard and is designed around goals that are distinct from Scheme's language-level features: quick startup time so it is practical to invoke for short-lived scripts, a built-in interface to operating system facilities so it can be used for day-to-day system administration and scripting tasks, and native support for handling multiple character encodings and languages. These implementation-level goals reflect Gauche's aim of being usable in the way a scripting language like Perl or Python would be, rather than being primarily a vehicle for programming language research or teaching.

## Ecosystem and use

Because Scheme is a standardized language rather than a single piece of software, it has many independent implementations beyond Gauche, each making its own choices about which standard to target and what additional features to provide; Gauche occupies a place among these implementations as one oriented specifically toward practical, production-style scripting rather than toward extending the language for research purposes or providing a full teaching environment. Gauche is distributed as free software and is used both as a general-purpose Scheme environment and, in keeping with its design goals, as a scripting tool for tasks that call for quick-starting programs with direct access to system facilities and to text in multiple character encodings.

## References

- [Wikipedia: Scheme](https://en.wikipedia.org/wiki/Scheme_(programming_language))
- [Wikipedia: Gauche](https://en.wikipedia.org/wiki/Gauche_(Scheme_implementation))

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
- `cat.scm`, `fizzbuzz.scm`, `printarg.scm`, `weekday-name.scm`, `square.scm`,
  `fact-iter.scm`, `test-square.scm`: standalone scripting exercises — `cat`,
  FizzBuzz, printing arguments, a weekday lookup, a square helper and its
  test, and an iterative factorial.
- `extent.scm`, `method.scm`, `next-method.scm`, `object.scm`, `slot.scm`:
  exercises of Gauche's object system — a closure acting as an object,
  generic methods, specializing a method with `next-method`, a class with
  init keywords, and a virtual slot backed by accessor procedures.
