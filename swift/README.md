# Swift

## Overview

Swift is a statically typed, compiled, general-purpose programming language developed by Apple. It is built around an emphasis on program correctness and predictable performance, combining features associated with systems languages, such as compiled native code and fine-grained memory management, with conveniences more commonly found in higher-level scripting languages, such as type inference and concise syntax. Swift was created to give Apple's platforms a language that keeps much of the interoperability and behavior of Objective-C while closing off entire categories of bugs at compile time rather than at runtime.

## History

Swift originated as a project of Chris Lattner, who began designing and implementing the language at Apple in July 2010. Other engineers joined the effort in earnest starting in late 2011, and the project grew into a major focus of Apple's Developer Tools group by 2013. Apple unveiled Swift publicly and released it for the first time in June 2014, with the toolchain shipping as part of Xcode 6 later that year. In December 2015, Apple released Swift as open-source software under the Apache License 2.0, opening its development, compiler, and standard library to outside contributors and enabling its use beyond Apple's own platforms. Subsequent major versions introduced substantial changes to the language's syntax and standard library, and later releases added ABI stability and, beginning with Swift 5.5, a built-in concurrency model.

## Language design and characteristics

Swift is statically typed, and its compiler performs type inference so that variable and expression types often do not need to be written explicitly, reducing verbosity without sacrificing compile-time checking. A central safety feature is the optional type, which requires values that may be absent to be explicitly represented and unwrapped before use, eliminating a broad class of null-reference errors that are common in languages without such a mechanism. The language gives equal standing to value types, such as structs and enums, alongside reference types (classes), encouraging value semantics where copies of data are independent of one another. Protocols, which describe requirements that types can conform to, together with generics, which allow code to be written abstractly over multiple types, are used pervasively in Swift's standard library and are often described as central to its design philosophy, sometimes termed protocol-oriented programming. Because Swift was designed to work alongside Objective-C codebases and Apple's existing Cocoa and Cocoa Touch frameworks, it supports two-way interoperability with Objective-C, including the ability to call Objective-C APIs from Swift and vice versa, while still enforcing Swift's own compile-time safety checks.

## Implementation and ecosystem

Swift manages memory automatically through automatic reference counting (ARC), which tracks and releases object references without requiring a tracing garbage collector, giving programs more deterministic memory behavior than garbage-collected languages. Starting with Swift 5.5, the language incorporated a structured concurrency model built around the `async`/`await` syntax, allowing asynchronous code to be written in a linear style, along with actors, which restrict access to their internal state to prevent data races between concurrently executing tasks, and a task-based API for managing units of asynchronous work. Since becoming open source, Swift's compiler and core tooling have been developed as a community project coordinated through swift.org, and the language has been ported beyond Apple's operating systems to run on Linux and, later, Windows.

## Uses and influence

Swift is the primary language for developing applications across Apple's platforms, including iOS, iPadOS, macOS, watchOS, and tvOS, where it works alongside or in place of Objective-C in existing codebases. Its open-source availability and portability to Linux and Windows have also allowed Swift to be used outside of Apple's ecosystem, including in server-side programming through community frameworks and in general cross-platform software development.

## References

- [Wikipedia: Swift (programming language)](https://en.wikipedia.org/wiki/Swift_(programming_language))

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
