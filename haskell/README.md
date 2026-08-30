# Haskell

## Overview

Haskell is a general-purpose, statically typed, purely functional programming language distinguished by its use of non-strict, or lazy, evaluation. Rather than emerging from a single designer's project, it was the product of a committee of researchers, and it has served as a standard, shared vehicle both for programming language research and, over time, for real-world software development.

## History

By the late 1980s a number of research groups had independently built very similar non-strict, purely functional languages, and the resulting fragmentation meant that no single one of them accumulated the users or implementation effort needed to develop it fully. To resolve this, a committee of researchers came together, prompted in part by discussion at the 1987 Functional Programming Languages and Computer Architecture conference, to design one common language that could unify this work. The resulting language was named Haskell after the logician Haskell Curry, whose work in combinatory logic underlies foundational ideas in functional programming. The committee's design was published as the Haskell 98 standard, and as more extensions to the language proliferated afterward, a later "Haskell Prime" committee produced a further standard, Haskell 2010, intended to consolidate widely used extensions into the language definition.

## Language design and characteristics

Haskell is purely functional, meaning that, in the core language, functions behave like mathematical functions and do not have side effects; the same inputs always produce the same outputs. It uses non-strict evaluation, so an expression is not evaluated until its value is actually needed, which allows programs to work with conceptually infinite data structures and to separate the description of a computation from when it is carried out. The language is statically typed, and its type system is built around type inference, so that types can usually be determined automatically without requiring explicit annotations throughout a program. Data is commonly structured using algebraic data types, and functions are commonly defined using pattern matching over the different forms such data can take, alongside pervasive support for higher-order functions that take other functions as arguments or return them as results. Haskell also introduced type classes, a mechanism for a controlled, type-directed form of operator and function overloading that lets the same function name be used with different behavior for different types.

## Implementation and ecosystem

Because Haskell is purely functional, it needs a disciplined way to express actions that have real-world effects, such as input and output, without breaking the guarantee that functions are pure; Haskell addresses this using monads, which let effectful and sequenced computations be expressed and combined as ordinary values within the pure language, with I/O being the most prominent example. The Glasgow Haskell Compiler, commonly known as GHC, is Haskell's principal implementation and compiles Haskell programs to native code across multiple platforms; in practice it has also gone well beyond the standard by supplying numerous language extensions, making it the central point around which most real-world Haskell development happens.

## Uses and influence

Haskell has been used extensively in academic research and in teaching functional programming and programming language theory, owing to its close correspondence with these languages' theoretical foundations, and it has also found use in industrial and production settings. Its type classes and its monadic approach to sequencing effects were novel contributions when introduced and have gone on to influence the design of type systems and effect-handling mechanisms in other later programming languages.

## References

- [Wikipedia: Haskell](https://en.wikipedia.org/wiki/Haskell)

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
- `etc`: a grab-bag of small standalone exercises reimplementing Unix
  utilities and control flow in Haskell (`case`, `cat`, `cp`, `echo`,
  `fizzbuzz`, `for`, `getchar`, `grep`, `if`, `leap`, `pwd`).
