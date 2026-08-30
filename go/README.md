# Go

## Overview

Go is a statically typed, compiled programming language developed at Google. It was designed to combine the safety and performance associated with statically typed compiled languages with the simplicity and fast iteration more commonly associated with dynamically typed scripting languages, with particular attention paid to compilation speed and to making concurrent programming straightforward.

## History

Go's design began in September 2007 at Google, led by Robert Griesemer, Rob Pike, and Ken Thompson. Pike and Thompson had spent years at Bell Labs working on Unix and later Plan 9, while Griesemer brought experience from work on virtual machines and runtimes; together they set out to address frustrations they and other engineers at Google had with the languages they were using at the time, including slow compilation, growing language complexity, and the difficulty of keeping very large, multi-author codebases understandable. The language was publicly announced and released as an open-source project in November 2009.

## Language design and characteristics

Go is statically typed, but its type system emphasizes structural typing for interfaces: a type satisfies an interface simply by implementing the interface's methods, without any explicit declaration linking the two, which keeps decoupled packages easy to compose. The language deliberately omits many features found in other languages of its era, such as classical class-based inheritance, in favor of a small, easily learned specification. Memory management is handled automatically through garbage collection, freeing programmers from manual allocation and deallocation while still aiming for predictable performance. Go's most distinctive feature is its built-in support for concurrency through goroutines, which are lightweight functions that the Go runtime schedules to run concurrently, and channels, which goroutines use to send and receive values safely without relying on explicit locks around shared memory. This model is directly influenced by Tony Hoare's theory of communicating sequential processes (CSP), which treats concurrent computation as independent processes coordinating by passing messages rather than by sharing state.

## Implementation and ecosystem

Go ships with a standard toolchain rather than leaving tooling to third parties: the `go` command handles building, testing, and running programs, `gofmt` automatically reformats source code into a single canonical style so that Go code looks consistent across projects and authors, and the built-in module system manages external package dependencies and versioning directly as part of the language's tooling.

## Uses and influence

Go's combination of fast compilation, straightforward concurrency, and a compact standard toolchain has made it a common choice for network services, cloud infrastructure, and systems-level tooling. It underlies widely used infrastructure software such as Docker and Kubernetes, and it is broadly used for building backend services and command-line tools where predictable performance and simple deployment matter.

## References

- [Wikipedia: Go (programming language)](https://en.wikipedia.org/wiki/Go_(programming_language))

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
- `hello.go`: a standalone hello-world program.
