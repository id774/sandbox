# Lua

## Overview

Lua is a lightweight, high-level, multi-paradigm programming language designed mainly for embedding inside other applications, though it is equally usable as a standalone scripting language for writing complete programs. Its distinguishing traits are a very small footprint, a compact and portable reference implementation, and a data model built around a single, flexible aggregate type. These properties have made it a common choice whenever a host program needs to expose a scripting or configuration layer to its users without carrying the weight of a larger language runtime.

## History

Lua originated in 1993 at Tecgraf, the Computer Graphics Technology Group of the Pontifical Catholic University of Rio de Janeiro (PUC-Rio) in Brazil, where it was created by Roberto Ierusalimschy, Luiz Henrique de Figueiredo, and Waldemar Celes. At the time, Brazil maintained strong trade barriers on imported computer hardware and software, which meant that Tecgraf's clients, including the Brazilian energy company Petrobras, could not readily obtain customized software from abroad. That environment pushed Tecgraf to build its own tools rather than license or import them. Lua's immediate predecessors were two data-description and configuration languages developed independently at Tecgraf in 1992 and 1993, known as SOL (Simple Object Language) and DEL (Data-Entry Language), each created to add flexibility to a separate project. Lua absorbed SOL's data-description syntax and took its name from the Portuguese word for "Moon," a deliberate follow-on to "Sol," the Portuguese word for "Sun." The language has continued to evolve through a numbered series of major releases since its first version, with its creators remaining its principal maintainers.

## Language design and characteristics

Lua is dynamically typed and works with a small number of atomic types, namely booleans, numbers (represented by default as double-precision floating-point values or 64-bit integers), and strings. Rather than offering separate built-in types for arrays, lists, sets, and records, Lua provides a single native aggregate type, the table, which programs use to represent all of these structures. Around this simple core the language layers a set of more advanced facilities: first-class functions, lexical closures, proper tail calls, automatic coercion between strings and numbers, cooperative multitasking through coroutines, dynamic loading of modules, and automatic garbage collection. Lua has no built-in notion of classes or inheritance, but its tables can carry an associated metatable whose metamethods (such as those governing addition or subtraction) let programs implement operator overloading and emulate object-oriented inheritance schemes on top of the table mechanism.

## Implementation and ecosystem

The reference implementation of Lua is written in ANSI C, which makes it portable across a wide range of platforms and small enough that a compiled interpreter occupies well under a megabyte. Embedding is central to the language's design: Lua exposes a compact C API that host applications use to load Lua code, exchange data with it, and expose their own functions back to Lua scripts, allowing the interpreter to be dropped into a larger C or C++ program with comparatively little integration work. This combination of a portable core and a simple embedding interface is what allows Lua to function equally well as a library linked into a host application and as a self-contained interpreter for standalone scripts.

## Uses and influence

Lua's embeddability and small size have made it a widely used scripting language in video game development, where it has repeatedly been identified in developer surveys as a leading choice for adding scripting capability to game engines. Its use extends well beyond games, however: it has served as the language for building the user interface of applications such as Adobe Photoshop Lightroom and is used inside the Redis key-value store to let users write and run custom functions directly on the server. More broadly, Lua is a common choice as a configuration and extension language for other software, letting applications expose customizable behavior to end users without embedding a heavier general-purpose language runtime.

## References

- [Wikipedia: Lua (programming language)](https://en.wikipedia.org/wiki/Lua)
