# CoffeeScript

## Overview

CoffeeScript is a programming language, created by Jeremy Ashkenas, whose defining trait is that it compiles directly into JavaScript rather than being executed by its own independent runtime. It was designed to expose what its author considered the better parts of JavaScript through a smaller, more concise syntax, while still producing ordinary JavaScript output capable of running anywhere a JavaScript engine does.

## History

Jeremy Ashkenas made the first commit of CoffeeScript on December 13, 2009, describing the project in that commit's message as "the mystery language." The compiler was initially written in Ruby, and the first tagged and documented release, version 0.1.0, followed on December 24, 2009. By February 21, 2010, with the release of version 0.5, Ashkenas replaced the original Ruby-based compiler with a self-hosting one written in CoffeeScript itself, meaning the language's own compiler was thereafter written in CoffeeScript and compiled to JavaScript like any other CoffeeScript program.

## Language design and characteristics

CoffeeScript's syntax draws on Ruby, Python, and Haskell. Like Python and Haskell, it uses significant indentation rather than curly braces to delimit blocks of code, following what is known as the off-side rule, and from Ruby it borrows conveniences such as string interpolation. Function literals are written far more tersely than in JavaScript, with the `function` keyword replaced by the short `->` symbol, and other common JavaScript constructs are likewise given more compact notation, reducing the amount of boilerplate needed to express everyday object, function, and control-flow code.

## Implementation and ecosystem

Because CoffeeScript compiles to JavaScript rather than running on a runtime of its own, it depends entirely on the JavaScript ecosystem for execution: compiled CoffeeScript code runs in any environment capable of running JavaScript, including web browsers and Node.js, and it can interoperate freely with existing JavaScript libraries and code. This reliance also extends to the compiler itself, which, once self-hosting, was written in CoffeeScript and produced JavaScript output like any other CoffeeScript program.

## Uses and influence

CoffeeScript found early adoption at the framework level: it was included by default in Ruby on Rails starting with version 3.1 in 2011 and was also supported by the Play Framework. Its influence extended to JavaScript itself, with Brendan Eich, JavaScript's creator, citing CoffeeScript in 2011 as an influence on his thinking about the language's future direction. Some prominent projects adopted it directly, such as Dropbox, which rewrote its browser-side codebase in CoffeeScript in 2012, though Dropbox later migrated that codebase to TypeScript in 2017. CoffeeScript's popularity declined over time following the 2015 publication of ECMAScript 6, a major revision to the JavaScript standard that natively incorporated many of the concise features, such as classes and more modern function syntax, that had previously made CoffeeScript an attractive alternative to writing JavaScript directly.

## References

- [Wikipedia: CoffeeScript](https://en.wikipedia.org/wiki/CoffeeScript)
