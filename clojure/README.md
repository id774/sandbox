# Clojure

## Overview

Clojure is a dynamically typed dialect of Lisp designed by Rich Hickey that runs primarily on the Java Virtual Machine, combining the syntactic uniformity and macro-based extensibility traditionally associated with Lisp with practical, direct access to the Java platform's libraries and tooling. It is built around a small set of ideas — immutability, first-class functions, and an explicit model for managing change over time — that together are meant to make concurrent and data-oriented programs easier to reason about than they typically are in languages built primarily around mutable state.

## History

Rich Hickey began working on Clojure in 2005 and spent roughly two and a half years developing it, much of that time working alone and without outside funding, before releasing it publicly in October 2007. The name Clojure is a play on the word "closure" that also incorporates letters from C#, Lisp, and Java, the three languages Hickey has cited as the most significant influences on its design; the choice of the Java platform in particular reflected a desire for a stable, well-performing foundation together with easy access to the large existing base of Java libraries.

## Language design and characteristics

As a dialect of Lisp, Clojure represents both code and data using the same underlying structures, such as lists, vectors, and symbols, a property known as homoiconicity that Clojure shares with other Lisps like Scheme and Racket. It treats functions as first-class values, provides a read-eval-print loop for interactive development, and includes a macro system, similar in spirit to Common Lisp's, that lets programmers extend the language itself, reduce boilerplate, and build domain-specific languages; Clojure's version of quoting, termed "syntax quote," additionally qualifies symbols with their namespace to guard against accidentally capturing names. Central to the language is its emphasis on immutable, persistent data structures — including persistent vectors, maps, and sets built on structures such as persistent hash array mapped tries — which allow what looks like an update to a collection to instead produce a new version that shares most of its structure with the old one. Clojure also provides lazy sequences as a uniform way of working with collections, together with multimethods and a protocol-based system for interface-like, polymorphic abstraction over data types and records.

## Implementation and ecosystem

Running on the JVM gives Clojure code direct interoperability with Java: Clojure programs can call into the extensive Java class library and use existing Java objects and classes directly, while benefiting from the JVM's portability and performance across operating systems. Hickey also designed ClojureScript, a variant of Clojure that compiles to JavaScript, extending the language beyond the JVM so that Clojure code can run in web browsers and other JavaScript environments.

## Uses and influence

Clojure's approach to concurrency rests on distinguishing an "identity" — a logical, named entity in a program — from the succession of immutable states that identity takes on over time; because each of those states is itself an immutable value, it can be freely read and shared across threads without locking. To manage the actual transition from one state to the next, Clojure supplies several reference types with distinct concurrency semantics: atoms, which are updated synchronously and independently using a compare-and-swap operation; refs, which are updated only within coordinated transactions under a software transactional memory system so that multiple refs can be changed together consistently; and agents, which support asynchronous, independent updates. This model, together with a standard library that treats data structurally, has made Clojure a language of choice for server-side application development, data processing, and other systems where correctness under concurrency is a central concern.

## References

- [Wikipedia: Clojure](https://en.wikipedia.org/wiki/Clojure)
