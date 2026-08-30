# Zig

## Overview

Zig is a statically typed, compiled programming language aimed at systems programming, where developers need low-level control over memory and machine behavior along with predictable performance. It is conceived largely as a general-purpose alternative to C, keeping the kind of direct control over hardware and memory layout that C offers while changing or removing language mechanisms that its design considers sources of hidden behavior or unnecessary complexity.

## History

Zig was created by Andrew Kelley, who began working on the language and first announced it publicly in a blog post in February 2016. Development has continued as an open-source project since then, and in 2020 Kelley founded the Zig Software Foundation, a non-profit organization established to support the language's continued development. As of its most recent releases the language and its compiler have not yet reached a 1.0 version, and Zig's design and standard library have continued to change between releases as the project works toward long-term stability.

## Language design and characteristics

Zig is presented as a general-purpose improvement on C, and it departs from C in a number of areas, including how control flow, function calls, module or library imports, and variable declarations are expressed, while still aiming to interoperate closely with existing C code, including the ability to import C header files directly. The language deliberately has no macro system and no separate text-based preprocessor; instead, metaprogramming and conditional compilation are handled through `comptime`, a mechanism that allows ordinary Zig code to be executed at compile time, enabling generic code, compile-time computation, and conditional inclusion of code without a separate macro language. Memory management in Zig is manual and explicit: the language has no built-in garbage collector, and rather than relying on a single global allocation strategy, functions and data structures are typically written to accept an allocator value explicitly, letting callers choose how memory is obtained and freed. Error handling is also explicit, using dedicated error types and control-flow constructs that require callers to acknowledge and handle or propagate errors, rather than relying on exceptions or other implicit control flow.

## Implementation and ecosystem

Zig's self-hosted compiler compiles source code directly to native machine code and includes built-in support for cross-compilation, allowing binaries for other target platforms to be produced without additional external toolchains. This same compiler can also be invoked as a standalone C and C++ compiler through the `zig cc` and `zig c++` commands, which gives Zig's toolchain use as a drop-in, cross-compiling replacement for a traditional C or C++ compiler even in projects that are not themselves written in Zig.

## Uses and influence

Because Zig remains pre-1.0, both the language and its standard library are still subject to change between releases, and the project treats this ongoing evolution as part of its path toward a stable release rather than as a finished design. It is used chiefly for systems-level and performance-sensitive software where direct control over memory and compilation targets is valued, and it is often discussed alongside other languages that position themselves as safer or more modern alternatives to C and C++.

## References

- [Wikipedia: Zig (programming language)](https://en.wikipedia.org/wiki/Zig_(programming_language))

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
