# Crystal

## Overview

Crystal is a general-purpose, object-oriented programming language whose syntax closely follows Ruby's, while its underlying execution model is that of a statically typed, compiled language rather than Ruby's dynamically typed interpreter. The language was designed so that most of the type checking Ruby defers to runtime instead happens before the program ever runs, catching a class of errors at compile time, while still letting programmers write code that reads much like idiomatic Ruby.

## History

Work on Crystal began in June 2011, driven by a goal of bringing together the expressiveness and productivity associated with Ruby and the raw execution speed and type safety of a compiled language. The project was initially called Joy before quickly being renamed Crystal. It was designed and developed by Ary Borenszweig, Juan Wajnerman, and Brian Cardiff, working through Manas Technology Solutions, together with a growing base of outside contributors. The compiler was originally implemented in Ruby itself; in November 2013 it became self-hosting once it was rewritten in Crystal, so that later versions of the compiler are built using the language they compile. Crystal subsequently moved through a series of pre-1.0 releases as the language and its standard library were stabilized, reaching a 1.0 release years after the project's initial announcement.

## Language design and characteristics

Crystal deliberately mirrors much of Ruby's surface syntax, including its block syntax and many of its keywords, so that code written in Crystal is often visually and idiomatically close to equivalent Ruby code. Underneath that familiar syntax, however, Crystal is statically typed, and it relies on a type inference system that deduces the types of variables and method results from context, so that explicit type annotations are usually unnecessary even though the compiler is enforcing types throughout. The language supports generics and compile-time macros, letting programs generate code and inspect types during compilation rather than at runtime. Because type checking and code generation happen ahead of time, Crystal cannot fully support some of Ruby's most dynamic runtime features, such as freely redefining behavior while a program is executing, which marks the clearest divergence between the two languages despite their syntactic closeness.

## Implementation and ecosystem

Crystal source is compiled ahead of time to native machine code using an LLVM backend, rather than being interpreted or run on a bytecode virtual machine. The compiler itself is self-hosted, being written in Crystal, and the project is distributed as open-source software. Crystal's concurrency model is built around lightweight, cooperatively scheduled fibers, with channels provided as the recommended way for fibers to exchange data safely. The language also provides bindings to C libraries, allowing Crystal programs to call into existing native code. Around the core language, a package ecosystem has grown up in which libraries, called shards, are distributed and versioned through a dedicated package manager, and community web frameworks have been built to support server-side application development.

## Uses and influence

Crystal is aimed at situations where developers want the concise, expressive feel of a Ruby-like language but also need the raw performance and compile-time safety of a natively compiled program, such as web backends and APIs, command-line tools, and other general-purpose software. Its influence has so far been mostly within the smaller community of languages seeking to pair dynamic-feeling syntax with static compilation, rather than reshaping mainstream language design the way older, more established languages have.

## References

- [Wikipedia: Crystal (programming language)](https://en.wikipedia.org/wiki/Crystal_(programming_language))
