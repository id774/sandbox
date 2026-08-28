# Java

## Overview

Java is a general-purpose, object-oriented programming language characterized by a class-based structure and static typing. Programs written in Java are compiled to an intermediate bytecode format that runs on the Java Virtual Machine (JVM) rather than being compiled directly to the instructions of a specific processor. Memory is managed automatically by the JVM's garbage collector rather than by the programmer, and the language's syntax draws heavily on C and C++ while omitting many of their lower-level features, such as direct pointer arithmetic. Java is deployed across a wide range of environments, including desktop applications, enterprise and web servers, and mobile devices.

## History

Java originated in June 1991 at Sun Microsystems, where James Gosling, Mike Sheridan, and Patrick Naughton began what became known internally as the Green Project, an effort to build a language and runtime for the kind of embedded, networked consumer devices that were expected to proliferate as computing, television, and telephony converged. Gosling led the design of the resulting language, which was first called Oak, reportedly after an oak tree that stood outside his office window. When the developers discovered that the name Oak was already claimed as a trademark by another company, the language was renamed Java, after Java coffee, ahead of its public introduction. As the project's focus shifted toward the rapidly growing World Wide Web, Sun released the language's first public implementation, Java 1.0, in 1996, distributing it with a promise that compiled programs could run unmodified on any device with a compatible Java runtime.

Sun Microsystems continued to direct the development of Java for more than a decade, during which it also began releasing Java's core implementation as open-source software through the OpenJDK project starting in 2006. Oracle Corporation took over stewardship of Java when it completed its acquisition of Sun Microsystems in January 2010, and it has overseen the language's specifications and reference implementation since. Oracle continues to release new versions of the platform and, together with the wider developer community, has built out the OpenJDK codebase into the primary, freely available implementation of the language.

## Language design and characteristics

Java is class-based and object-oriented, meaning that programs are organized around classes that define the state and behavior of objects, and it enforces static typing, so that the types of variables and expressions are checked before a program runs. Source code is compiled not into machine code for a particular processor but into bytecode, a portable instruction format executed by the Java Virtual Machine. Because any platform with a conforming JVM can execute the same bytecode, Java was promoted under the slogan "write once, run anywhere," meaning specifically that a single compiled program does not need to be recompiled for each target platform, only run under a JVM built for that platform. The JVM also takes responsibility for memory management: objects are allocated automatically and reclaimed by a garbage collector once they are no longer reachable, relieving programmers of manual allocation and deallocation.

## Implementation and ecosystem

The language and its libraries are formalized as the Java Platform, Standard Edition (Java SE), a specification covering the core language and the standard class library used across desktop and server applications. For much of Java's history, changes to the platform were developed through the Java Community Process (JCP), a mechanism established in 1998 that lets outside organizations and individuals propose and review specifications for Java technologies, though its influence has narrowed since Oracle's acquisition of Sun. OpenJDK, begun by Sun in 2006 and released under an open-source license, has served as the official reference implementation of Java SE since Java SE 7 and remains the most widely used distribution of the platform's runtime and development tools.

## Uses and influence

Java's combination of portability and automatic memory management made it a common choice for enterprise and server-side software, including web applications built on specifications such as Java EE and delivered through server-side components like servlets. On the desktop, Java has been used both for standalone applications built with GUI toolkits such as Swing and, in its early years, for applets that ran inside web browsers, a mechanism that browser vendors eventually dropped and that Sun and Oracle deprecated in Java 9. Java also became a foundational language for Android application development, although Android's own runtime and libraries diverge from the standard Java SE platform. Beyond applications written directly in Java, the language's bytecode format and virtual machine gave rise to a broader ecosystem of JVM-based languages, including Kotlin, Scala, Groovy, and Clojure, which compile to the same bytecode and can interoperate with Java libraries and with one another.

## References

- [Wikipedia: Java (programming language)](https://en.wikipedia.org/wiki/Java_(programming_language))
