# Elixir

## Overview

Elixir is a dynamically and strongly typed functional programming language built to run on the Erlang virtual machine, known as BEAM. It combines a syntax influenced by Ruby with the concurrency and fault-tolerance model that Erlang has long used for building highly available systems, and it was created specifically to make that model more approachable and productive to work with day to day.

## History

Elixir was designed by José Valim and first released in 2012. Valim had been a core contributor to the Ruby on Rails web framework and valued the expressiveness and developer ergonomics of Ruby, but found that Ruby's tooling and runtime made it difficult to build systems that scaled across multiple cores and handled failure gracefully. Rather than starting from nothing, he chose to build a new language on top of Erlang's existing virtual machine, so that Elixir could inherit BEAM's mature approach to concurrency and reliability while presenting a more modern syntax and toolchain on top of it. The language has continued to evolve since its initial release under Valim's continued stewardship of its design and standard library.

## Language design and characteristics

Elixir is a functional language: data is immutable, and computation is expressed through function application and transformation of values rather than mutation of state. Pattern matching is used pervasively, both in ordinary variable binding and in function clause selection, allowing functions to be defined as a set of alternative clauses that match different shapes of input. Because Elixir runs on BEAM, it inherits Erlang's process model: concurrency is expressed through very lightweight, independently scheduled processes that do not share memory and that communicate exclusively by sending and receiving messages. These processes are the basis for Elixir's fault-tolerance story, which follows Erlang's practice of isolating failures to individual processes and supervising and restarting them rather than trying to defensively guard against every possible error. Beyond what it takes directly from Erlang, Elixir adds compile-time metaprogramming through macros, which let code that runs at compile time generate and transform other code, and protocols, which provide a form of polymorphism where a function's behavior can be specialized per data type without modifying the original type's definition.

## Implementation and ecosystem

Elixir code compiles down to BEAM bytecode, the same form Erlang code compiles to, which gives Elixir full interoperability with existing Erlang code and with OTP, Erlang's set of libraries and design patterns for building fault-tolerant applications, without any runtime translation cost. Elixir programs can call Erlang modules directly and vice versa, and Elixir's own standard library and supervision constructs are built on top of OTP's abstractions. Around the language, an ecosystem of tooling and libraries has grown, most notably the Phoenix web framework, which is used to build web applications and real-time features on top of Elixir's concurrency model.

## Uses and influence

Elixir is principally used to build concurrent, distributed, and fault-tolerant systems, and, through Phoenix, web applications and services that need to handle many simultaneous connections reliably. Its combination of an approachable syntax with BEAM's concurrency and fault-tolerance guarantees has made it a language of choice for systems where uptime and responsiveness under load matter, including in telecommunications, e-commerce, and finance.

## References

- [Wikipedia: Elixir (programming language)](https://en.wikipedia.org/wiki/Elixir_(programming_language))

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
