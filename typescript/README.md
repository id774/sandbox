# TypeScript

## Overview

TypeScript is a programming language that extends JavaScript by adding a static type system on top of it. It is designed as a superset of JavaScript, meaning that valid JavaScript source code is, with few exceptions, also valid TypeScript, so existing JavaScript code and libraries can generally be adopted incrementally rather than rewritten. The language's central purpose is to let developers describe the shapes of their data and the signatures of their functions so that a broad class of mistakes can be caught while writing code, rather than only when it runs.

## History

TypeScript was developed by Microsoft, with Anders Hejlsberg, known for his earlier work on languages such as Turbo Pascal, Delphi, and C#, serving as its lead architect. Microsoft first made the language public in 2012, positioning it explicitly as a typed superset of JavaScript aimed at making the development of large applications more manageable. The language and its compiler were released as free and open-source software, and it has continued to be developed and released in successive versions that track the evolution of the underlying ECMAScript standard.

## Language design and characteristics

TypeScript's typing is optional and gradual: annotations can be added incrementally, and code without explicit type annotations is still processed, with the compiler inferring types where it can. Its type system is structural rather than nominal, meaning that two types are considered compatible if their members and shapes match, regardless of how or where they were declared, which contrasts with nominal type systems that treat types as compatible only when they share an explicit named relationship, such as inheritance. Type checking happens at compile time, and this is followed by type erasure, in which the type annotations are stripped out entirely, so the type system exists purely to help authors and tools during development and has no representation or cost at runtime. The TypeScript compiler transpiles this typed source code into plain JavaScript, and it can be configured to target different versions of the ECMAScript standard, allowing newer syntax to be converted into equivalent code that runs on older JavaScript engines.

## Implementation and ecosystem

Because type erasure removes annotations before code runs, TypeScript relies on a system of declaration files, conventionally using a `.d.ts` extension, to describe the types of JavaScript code and libraries that were not themselves written in TypeScript. Many popular JavaScript libraries do not ship their own type declarations, and the community-maintained DefinitelyTyped repository collects and distributes declaration files for a large number of such libraries so that they can still be used with full type checking from TypeScript. This type information is also what enables much of TypeScript's value in editor and IDE tooling, where it powers features such as autocompletion, inline error checking, and reliable code navigation and refactoring, which are particularly useful as codebases and teams grow larger.

## Uses and influence

TypeScript is used widely for building and maintaining large-scale JavaScript applications, where its static checking and tooling support help teams catch errors early and navigate unfamiliar code with more confidence than plain JavaScript typically allows. It is important to note that TypeScript is not a separate runtime or a replacement for JavaScript: TypeScript code is always compiled down to ordinary JavaScript, and it is that generated JavaScript which executes on existing JavaScript engines, such as those in web browsers or Node.js.

## References

- [Wikipedia: TypeScript](https://en.wikipedia.org/wiki/TypeScript)
