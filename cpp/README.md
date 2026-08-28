# C++

## Overview

C++ is a general-purpose programming language that is compiled to native machine code and statically typed, meaning variable types are checked before a program runs rather than while it executes. It was conceived as an extension of the C language, retaining C's low-level access to memory and hardware while layering on facilities for organizing larger programs. Rather than committing to a single style of programming, C++ is deliberately multi-paradigm: the same language can be used procedurally, in an object-oriented style built around classes and inheritance, or generically through templates, and a program is free to mix these approaches as needed.

## History

C++ traces back to 1979, when Bjarne Stroustrup, then working on his PhD-related research at Bell Labs, began extending the C language with class-based constructs modeled on ideas he had encountered in Simula. He called this early effort "C with Classes," aiming to combine Simula's support for structuring large programs with C's efficiency, since Simula itself was considered too slow for demanding systems work. Stroustrup continued refining the language through the early 1980s, and in 1983 it was renamed C++, a name suggested by Rick Mascitti that plays on C's own `++` increment operator to signal an incremental step beyond C. The language saw its first commercial release in 1985. Through the following decade its feature set kept expanding, notably with the incorporation of a template-based Standard Template Library developed by Alexander Stepanov and Meng Lee, which the standards committee adopted into the language's library in the mid-1990s. C++ received its first ISO standard in 1998, and the language has since gone through a sequence of major revisions, including C++03, C++11, C++14, C++17, C++20, and C++23, each expanded and refined by the ISO working group responsible for the language.

## Language design and characteristics

C++'s multi-paradigm design lets a single program combine procedural code, object-oriented constructs such as classes, inheritance, and virtual functions, and generic programming through templates, which allow functions and classes to be written independently of the specific types they operate on and instantiated for concrete types at compile time. A distinguishing idiom in C++ is RAII (Resource Acquisition Is Initialization), where a resource such as memory, a file handle, or a lock is tied to the lifetime of an object, so that the resource is automatically released when that object goes out of scope; this gives C++ programs a form of deterministic resource management without relying on automatic garbage collection. The language's standard library, including the STL-derived containers, iterators, and algorithms, builds on these features to provide reusable, type-generic data structures and operations. Because C++ compiles directly to native machine code rather than running through a virtual machine, programs can execute with performance close to the underlying hardware, at the cost of giving programmers more direct responsibility for memory and resource management than languages with managed runtimes.

## Implementation and ecosystem

There is no single official C++ implementation; instead, the ISO standard defines the language and its library, and multiple independent compilers implement that standard, including GCC, Clang, and Microsoft's Visual C++. Each major standard revision has driven corresponding updates across these compilers and their standard library implementations. The language's evolution is directed by the ISO working group responsible for C++, which continues to publish new standard revisions that add core-language features and extend the standard library.

## Uses and influence

C++'s combination of low-level control and higher-level abstraction has made it a common choice for systems software such as operating system components and device drivers, for game engines and other performance-sensitive applications, and for domains such as browsers and embedded systems where efficient use of hardware resources matters. Beyond its direct applications, C++ has influenced the design of numerous later languages, including Java and C#, which adopted aspects of its object-oriented syntax and class-based model, and it remains a reference point in discussions of systems programming and software engineering practice more broadly.

## References

- [Wikipedia: C++](https://en.wikipedia.org/wiki/C%2B%2B)
