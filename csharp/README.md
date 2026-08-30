# C#

## Overview

C# is a general-purpose programming language that is statically typed and runs on a managed execution environment rather than compiling straight to native machine code. It was built from the outset as the primary language for Microsoft's .NET platform, and its design accordingly reflects .NET's own model of compiling source code to an intermediate representation that is executed and managed by a runtime rather than run directly on hardware. C# combines a core of object-oriented constructs, such as classes and interfaces, with imperative, generic, and functional-influenced features layered on over the course of the language's development.

## History

C# was developed at Microsoft in the late 1990s by a team including Anders Hejlsberg, Scott Wiltamuth, and Peter Golde, as part of the same effort that produced the .NET platform. Hejlsberg came to the project with a background as the chief architect of Turbo Pascal and Delphi at Borland, and he served as the lead designer of C#. Microsoft first widely distributed C# in 2000 as part of the initial release of the .NET Framework. The language was subsequently put through formal standardization, being adopted as an Ecma standard in 2002 and as an ISO/IEC standard in 2003, with the standard revised as the language itself grew. Later versions of C# introduced substantial new capabilities on top of the original design, including generics, delegates as a way of representing method references, LINQ for querying collections and other data sources with integrated syntax, and async/await support for writing asynchronous code in a straightforward, sequential style.

## Language design and characteristics

C# is statically typed, so the type of every variable and expression is fixed and checked before the program runs. Rather than compiling to native code directly, C# source is compiled to Common Intermediate Language, which the .NET Common Language Runtime then executes, applying just-in-time compilation and providing services such as automatic memory management through garbage collection. This managed execution model relieves programmers of manual memory deallocation while still allowing the CLR to enforce type and memory safety at runtime. On top of an object-oriented core built around classes, interfaces, and inheritance, C# layers component-oriented features such as properties, events, and delegates, along with generics for writing type-safe reusable code, LINQ for expressing queries in the language itself, and async/await for structuring non-blocking, asynchronous operations.

## Implementation and ecosystem

C# was originally tied to the Windows-only .NET Framework, but its ecosystem has since become cross-platform. Microsoft open-sourced the Roslyn compiler platform used to build and analyze C# code, and introduced .NET Core as an open-source, cross-platform runtime and framework capable of running C# programs on Windows, Linux, and macOS; this cross-platform work was later unified under the plain ".NET" branding beginning with .NET 5. Development tooling for C# spans Microsoft's own Visual Studio as well as the cross-platform, open-source Visual Studio Code editor.

## Uses and influence

C#'s tight integration with .NET has made it a common choice for Windows desktop applications, enterprise and web applications built with frameworks such as ASP.NET, and cloud services hosted on platforms like Microsoft Azure. It is also widely used in game development, most notably as the primary scripting language of the Unity game engine.

## References

- [Wikipedia: C Sharp (programming language)](https://en.wikipedia.org/wiki/C_Sharp_(programming_language))

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
