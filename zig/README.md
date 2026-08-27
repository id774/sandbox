# Zig

Zig is a statically typed, compiled systems programming language that emphasizes explicit control over memory, errors, and program behavior. It provides compile-time execution, direct C interoperability, manual allocation strategies, and native-code compilation without a garbage collector.

As described on [Wikipedia](https://en.wikipedia.org/wiki/Zig_(programming_language)), Zig is intended as a general-purpose improvement on C, differing in areas such as control flow, function calls, library imports, and variable declarations while dropping macros and a separate preprocessor entirely. Its `comptime` keyword lets code run at compile time to achieve effects similar to macros and conditional compilation, and its self-hosted compiler doubles as a C and C++ compiler through the `zig cc` and `zig c++` commands.
