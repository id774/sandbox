# ActionScript

## Overview

ActionScript is an object-oriented programming language used to script interactive content and applications built with Macromedia's and later Adobe's Flash authoring tools. It is an implementation of the ECMAScript specification, making it a syntactic and semantic relative of JavaScript, although the two languages developed somewhat independently and share a common debt to HyperCard's HyperTalk scripting language rather than one being derived from the other. Over successive versions, ActionScript grew from a simple scripting facility for animating and controlling Flash movie clips into a general-purpose language capable of building complete applications, games, and rich internet applications.

## History

ActionScript was originally developed by Macromedia for use with the Flash platform. Macromedia was acquired by Adobe Systems in 2005, and Adobe subsequently took over stewardship and continued development of the language. ActionScript 2.0 followed in September 2003 with the release of Flash MX 2004 and Flash Player 7, adding class-based syntax and compile-time type checking while still compiling down to the same bytecode as ActionScript 1.0, which let ActionScript 2.0-authored content continue to run on the earlier Flash Player 6. The most significant change came in June 2006, when ActionScript 3.0 debuted alongside Adobe Flex 2.0 and Flash Player 9. This release amounted to a fundamental restructuring of the language rather than an incremental update, and it required an entirely new virtual machine to execute it.

## Language design and characteristics

ActionScript 1.0 used prototype-based inheritance and loose, dynamic typing, similar in spirit to early JavaScript, where shared behavior was defined on prototype objects rather than formal classes. ActionScript 2.0 introduced class-based syntax, including `class` and `extends` keywords, and allowed developers to annotate variables with a specific type so that type mismatches could be caught at compile time, though its underlying object model still ultimately compiled to ActionScript 1.0 bytecode. ActionScript 3.0 completed the shift to class-based object orientation, adding formal classes, interfaces, packages, and sealed class members alongside optional static typing, so that a variable could be declared with a fixed type for compiler-checked safety and improved performance while dynamic typing remained available where flexibility was preferred.

## Implementation and ecosystem

ActionScript 1.0 and 2.0 executed on the original ActionScript Virtual Machine (AVM1), which interpreted bytecode without native compilation. ActionScript 3.0, by contrast, runs on a completely rewritten virtual machine, AVM2, built as part of an effort that Adobe carried out jointly with the Mozilla Foundation; in 2006 the AVM2 codebase was donated to Mozilla as open source to seed the Tamarin virtual machine project, which aimed to help implement a proposed ECMAScript 4 standard. AVM2 introduced a just-in-time compiler that translates bytecode into native machine code at runtime, giving ActionScript 3.0 substantially better performance than the interpreted execution used by earlier versions. Beyond the Flash Player runtime, ActionScript 3.0 is also used with Adobe AIR, a runtime that lets Flash and ActionScript content be packaged as standalone desktop and mobile applications for platforms such as Windows, macOS, Android, and iOS, running independently of a browser plug-in.

## Uses and influence

For most of its history, ActionScript was the scripting language behind the Flash ecosystem's web animations, games, and rich internet applications, and it was used together with tools such as Flash Builder and the Flex framework to build larger applications. Adobe officially discontinued Flash Player at the end of 2020, removing its download page shortly afterward, and from January 2021 onward Flash Player versions released after that point refuse to play Flash content and display a warning instead. This ended ActionScript's role as a mainstream browser scripting language, but ActionScript 3.0 remains in use through Adobe Animate, the successor to Flash Professional, and through Adobe AIR for building standalone applications and games outside the browser plug-in model.

## References

- [Wikipedia: ActionScript](https://en.wikipedia.org/wiki/ActionScript)

## Layout

- `Hello.as`, `ImageCircle.as`: standalone Flash display-list snippets, one
  drawing text onto the stage and one loading an image into a circular mask.
- `onsg8_calcuator`, `onsg8_hello`, `onsg8_timer`: three Flash Builder / Flex
  projects from an "ONSG8" exercise set (a calculator, a hello-world app, and
  a timer), each an MXML source under `src` plus its Eclipse/Flex project
  metadata.
