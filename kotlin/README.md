# Kotlin

## Overview

Kotlin is a statically typed, general-purpose programming language developed by JetBrains that places a strong emphasis on interoperability with Java and the wider Java Virtual Machine ecosystem. It combines type inference with a concise syntax intended to reduce the boilerplate common in Java code, and it can be compiled to more than one target platform beyond the JVM. Kotlin has become closely associated with Android application development, where Google has designated it as its preferred language.

## History

JetBrains, the company best known for the IntelliJ IDEA development environment, began work on Kotlin with a first commit to its repository in November 2010 and unveiled the language publicly as "Project Kotlin" in July 2011, after roughly a year of development. Its name comes from Kotlin Island, near Saint Petersburg, echoing the way Java itself was named after the Indonesian island of Java. JetBrains open-sourced Kotlin under the Apache 2.0 license in February 2012, and the project has continued to be led and funded primarily by JetBrains since, alongside an open-source community.

## Language design and characteristics

Kotlin is statically typed but uses type inference extensively, allowing many variable and expression types to be omitted from source code while still being checked by the compiler. A central design goal is built-in null safety: Kotlin's type system distinguishes types that may hold a null value from those that may not, catching a common category of null-reference errors at compile time rather than at run time. The language also supports extension functions, which let developers add new functions to existing classes without modifying or subclassing them, alongside other features aimed at concise, readable code. For asynchronous and concurrent programming, Kotlin provides coroutines, a language feature that lets code perform non-blocking operations while still being written and read in a straightforward, sequential style.

## Implementation and ecosystem

Kotlin was designed from the outset to interoperate fully with Java: its standard library on the JVM builds on the Java Class Library, and Kotlin code can call Java libraries and be called from Java code with little friction, which has made incremental adoption inside existing Java codebases practical. While the JVM remains Kotlin's primary compilation target, the language also compiles to JavaScript, for use in web frontends, and to native machine code by way of LLVM, allowing Kotlin to run in environments without a JVM, including native iOS binaries. This multi-target compilation underlies Kotlin Multiplatform, a JetBrains technology first previewed at KotlinConf in 2017 and refined through subsequent Kotlin releases, which lets developers share a single Kotlin codebase, particularly business logic, across Android, iOS, desktop, web, and server targets while still writing platform-specific code where it is needed.

## Uses and influence

Kotlin's closest association is with Android, where Google gave it first-class support at Google I/O in 2017 and then, in 2019, named it its preferred language for Android application development; by the mid-2020s, the great majority of top Android applications on Google Play contained Kotlin code. Beyond Android, Kotlin is also used for server-side development on the JVM, where it draws on the same libraries and frameworks available to Java, and Kotlin Multiplatform has extended its reach into cross-platform mobile and desktop development, positioning Kotlin as both an entry point into the JVM ecosystem and a language for sharing code across otherwise separate platforms.

## References

- [Wikipedia: Kotlin (programming language)](https://en.wikipedia.org/wiki/Kotlin_(programming_language))
