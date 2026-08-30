# Scala

## Overview

Scala is a general-purpose programming language that runs primarily on the Java Virtual Machine and is built around the premise that object-oriented and functional programming are not competing paradigms but can be unified in a single, statically typed language. It interoperates closely with Java, letting Scala code call Java libraries and vice versa, while offering a type system and a set of functional constructs considerably more expressive than Java's own. The name itself is a portmanteau of "scalable" and "language," reflecting an original design goal of a language that could scale from small scripts to large, component-based systems.

## History

Scala's design was begun in 2001 by Martin Odersky and his research group at the École Polytechnique Fédérale de Lausanne (EPFL), building on earlier work Odersky had done on adding functional-programming features to Java. The language had its first public release a few years later, and Odersky and his group continued to lead its development afterward, both as an academic research effort and, eventually, through commercial backing for the surrounding tooling and ecosystem. Over the following years, Scala's compiler and standard library went through what became known as the Scala 2 line, which saw widespread adoption; a substantial redesign of the language and its compiler, developed under the working name Dotty, was subsequently released as Scala 3, introducing a reworked type system along with new and simplified syntax while aiming to remain largely interoperable with existing Scala 2 code and libraries.

## Language design and characteristics

Scala is statically typed and follows Java in treating essentially everything as an object, but it layers on a considerably richer type system that supports generics, type inference, and other advanced typing features not present in Java. At the same time, functions are first-class values in Scala, and the language provides higher-order functions that take other functions as arguments or return them, pattern matching for destructuring and branching on the shape of data, and support for immutability as an idiomatic default, with values and data structures that do not change after creation. Lazy evaluation is also available as a language feature, letting a value's computation be deferred until it is actually needed rather than computed eagerly. This blend lets the same codebase mix imperative, object-oriented constructs with functional ones, such as composing pure functions and using immutable collections, without stepping outside a single coherent language.

## Implementation and ecosystem

Scala compiles to Java Virtual Machine bytecode by default, which is what gives it its interoperability with the broader Java ecosystem, including the ability to use existing Java libraries directly from Scala code. Beyond the JVM, the ecosystem has grown alternative compilation targets: Scala.js compiles Scala source to JavaScript, allowing Scala to be used for front-end and other JavaScript-hosted code, while Scala Native compiles Scala ahead of time to native machine code with a lightweight runtime, independent of the JVM. Together with the standard JVM target, these give Scala code a route to running in browsers, on the JVM, and as standalone native binaries from largely the same source.

## Uses and influence

Scala's combination of JVM interoperability, strong typing, and functional programming support has made it a common choice for backend and data-oriented systems, and it underpins some widely used infrastructure in the distributed-systems and data-processing space, including large-scale data processing and messaging frameworks that are themselves written in Scala. Its functional features and type system have also influenced how developers approach concurrent and data-intensive workloads on the JVM more generally, extending the language's impact beyond codebases written directly in Scala.

## References

- [Wikipedia: Scala (programming language)](https://en.wikipedia.org/wiki/Scala_(programming_language))

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
- `HelloWorld.scala`, `HelloWorldScript.sh`: a standalone hello-world program
  and the script that runs it.
- `loop`: five microbenchmarks timing loop and hash-map-insert variants
  (`example01.scala` through `example05.scala`).
