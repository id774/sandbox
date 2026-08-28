# Dart

## Overview

Dart is a general-purpose programming language developed by Google, designed with client application development as its central goal rather than as an afterthought. It is class-based and object-oriented, uses garbage collection for automatic memory management, and is statically typed, so that the shape of data flowing through a program is checked before the program runs. Dart was conceived to support building applications for mobile devices, the web, and desktop from a single language, and its tooling and compilation strategy are shaped around making that kind of client development fast to iterate on and efficient to ship.

## History

Dart was designed by Lars Bak and Kasper Lund, both of whom brought experience from building high-performance language runtimes, and it was developed at Google. The language was unveiled publicly at the GOTO conference in Aarhus, Denmark, in October 2011. Its first stable 1.0 release followed in 2013, and a significant later milestone, Dart 2.0 in 2018, made the language's static type system the default rather than optional. The language's trajectory changed significantly with the 2017 release of the Flutter framework, which is built on top of Dart and has since become the primary reason most developers encounter the language.

## Language design and characteristics

Dart is class-based and object-oriented, supporting single inheritance along with interfaces and mixins, and it manages memory automatically through garbage collection rather than requiring manual deallocation. The language is statically typed, using type inference to reduce the need for explicit annotations, and later versions introduced null safety, under which variables cannot hold a null value unless their type is explicitly declared nullable, which is intended to eliminate a common class of null-reference errors before a program ever runs. Dart supports two distinct compilation modes: a just-in-time compiler that enables fast incremental recompilation and features like stateful hot reload during development, and an ahead-of-time compiler that produces optimized native machine code for deployed applications.

## Implementation and ecosystem

The Dart SDK includes a virtual machine offering both the JIT and AOT compilation paths described above, as well as separate compilers that translate Dart code to JavaScript or to WebAssembly so that Dart applications can run inside standard web browsers. Packages are shared through a central repository, and the standard library provides core collections, asynchronous programming support, and I/O facilities for programs running directly on the Dart VM.

## Uses and influence

Dart's most prominent use is as the language underlying Flutter, Google's framework for building natively compiled mobile, web, and desktop applications from a single codebase, and this association has become the primary way most developers encounter Dart today. Beyond Flutter-based client applications, Dart is also used for command-line tools and server-side programs, reflecting its original design as a general-purpose language rather than one restricted to a single kind of target.

## References

- [Wikipedia: Dart (programming language)](https://en.wikipedia.org/wiki/Dart_(programming_language))
