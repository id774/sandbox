# C

## Overview

C is a general-purpose, procedural programming language notable for the direct control it gives programmers over a computer's memory and hardware while still remaining portable across many different machine architectures. It was designed with efficient execution in mind rather than as a vehicle for high-level abstraction, and that combination of low-level power with a comparatively small and simple core language has made it one of the most consequential programming languages in the history of computing.

## History

C was created between 1972 and 1973 by Dennis Ritchie at Bell Labs. It grew directly out of an earlier language called B, which Ken Thompson had developed by simplifying BCPL, itself blending BCPL's semantics with syntax drawn from a simplified form of ALGOL. Because B's types were not well suited to the more capable PDP-11 hardware Bell Labs was then using, Ritchie extended B with richer types, including arrays of integers and characters, pointers, and the ability for functions to return values of specific types; a new compiler was written for this enriched language, which was accordingly renamed C. C's initial purpose was building utility programs to run on the Unix operating system, and it was soon used to rewrite the Unix kernel itself, cementing a close relationship between the language and the operating system it helped build. The language's authoritative early description came from the book "The C Programming Language" by Brian Kernighan and Dennis Ritchie, first published in 1978, whose version of the language is often called K&R C and which served as the de facto standard before a formal one existed.

## Language design and characteristics

C is a statically typed, procedural (imperative) language: programs are expressed as sequences of statements and function calls operating on typed variables, rather than through the object-oriented or declarative paradigms found in many later languages. Its most distinctive feature is direct support for pointers, which let a program manipulate memory addresses explicitly, including performing pointer arithmetic without built-in bounds checking, which grants full control over the hardware, such as configuring platform-specific control and status registers, but also makes C programs prone to memory-safety errors if used carelessly. Memory in C is managed manually rather than through automatic garbage collection, with functions such as `malloc` used to allocate memory that the program must later free itself. The language itself has a deliberately small runtime, leaving most functionality to be supplied by libraries rather than built into the language.

## Implementation and ecosystem

C source code is compiled ahead of time into native machine code rather than interpreted, which lets compiled C programs run efficiently on the target hardware. Compilers for C exist for a very wide range of processor architectures and operating systems, and this combination of low-level efficiency with broad compiler availability is a major reason the language is considered highly portable despite operating so close to the hardware. C is accompanied by a standard library that supplies fundamental facilities the language core omits, including input and output through `stdio.h`, string handling through `string.h`, mathematical functions through `math.h`, memory management and general utilities through `stdlib.h`, and time and date handling through `time.h`. The language's specification has been formally standardized: the American National Standards Institute formed the X3J11 committee in 1983, which produced the ANSI X3.159-1989 standard commonly referred to as ANSI C or C89, and in 1990 the International Organization for Standardization adopted essentially the same text, with only formatting changes, as ISO/IEC 9899:1990, known as C90 — so that "C89" and "C90" describe the same language. Since then, ANSI has deferred to the international standard maintained by ISO/IEC's working group.

## Uses and influence

C's success and ubiquity have made it the ancestor of a large family of later programming languages that borrowed aspects of its syntax or design, commonly cited examples including C++, C#, Objective-C, Java, JavaScript, Perl, PHP, Python, Ruby, Go, Rust, Swift, and D, among many others. C++ in particular extends C directly, layering object-oriented programming, exception handling, and a standard template library on top of a language that remains close to C at its core, and Java's syntax is in turn heavily influenced by C and C++. In practical use, C has been applied above all to systems programming: it has been used to implement operating system kernels and utilities (beginning with Unix itself), device drivers, embedded systems software, and low-level libraries, contexts where its efficiency and direct hardware access are valued most.

## References

- [Wikipedia: C (programming language)](https://en.wikipedia.org/wiki/C_(programming_language))

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
- `chroot_and_getcwd.c`, `escape_from_chroot.c`, `GHOST.c`, `segfault.c`:
  low-level systems and security probes — printing a working directory across
  a `chroot`, escaping a chroot jail, detecting the glibc GHOST vulnerability
  (CVE-2015-0235), and deliberately overrunning a fixed-size array.
- `fizzbuzz.c`, `hoge.c`, `msrand.c`, `unixtime.c`: small standalone
  exercises — FizzBuzz, truncated integer division, a minimal-standard linear
  congruential generator, and `ctime` on boundary `time_t` values.
- `socket.c`: a bare TCP listener that accepts and immediately closes each
  connection.
- `ipc_socket`: a matching echo client and server pair that exchange lines
  over a socket.
- `is_prime`: a standalone primality check.
- `ruby`: a native Ruby C extension (`mytest`), with its `extconf.rb` and a
  script that loads and calls it.
