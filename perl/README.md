# Perl

## Overview

Perl is a high-level, general-purpose, dynamically typed programming language originally built for practical text and report processing on Unix systems. It is a multi-paradigm language, supporting procedural, object-oriented, and functional styles of programming within the same codebase, and it is particularly known for the depth of its built-in support for regular expressions and string manipulation. Perl's design draws deliberately on earlier Unix tools, borrowing ideas from languages such as C, sh, AWK, and sed and combining them into a single, more expressive scripting language.

## History

Larry Wall began developing Perl in 1987 while working as a programmer at Unisys, releasing version 1.0 on December 18, 1987, as a general-purpose Unix scripting language meant to make report processing easier. The language evolved quickly over its next several major releases: Perl 2, in June 1988, introduced an improved regular-expression engine; Perl 3, in October 1989, added support for binary data streams; and Perl 4 followed in March 1991. Perl 5, released as version 5.000 on October 17, 1994, was a nearly complete rewrite of the interpreter that added objects, references, lexically scoped ("my") variables, and a module system, and it has remained the current major version of the language ever since, with development continuing through many subsequent minor releases. A long-planned successor, Perl 6, developed in parallel for many years, eventually diverged so far from Perl 5 in design that it was formally renamed Raku in October 2019, leaving Perl 5 as the language now referred to simply as Perl.

## Language design and characteristics

Perl's core data types are scalars, arrays, and hashes (associative arrays), which are distinguished from one another by different leading sigils, with arrays marked by "@" and their individual elements accessed through the scalar sigil "$"; the hash data type was itself drawn from AWK, just as Perl's regular expression syntax was drawn from sed. The language is dynamically typed and provides automatic memory management, and many of its built-in functions behave differently depending on whether they are evaluated in list context or scalar context, a design that Perl's own documentation has wryly summarized by saying that such functions "do what you want, unless you want consistency." Structurally, Perl is procedural at its core, with variables, expressions, assignment statements, brace-delimited blocks, and control structures whose overall shape derives from C, but its interpreter also has an object-oriented architecture internally, and the language exposes object-oriented programming to Perl code itself, alongside functional-style idioms, so that a single program can freely mix all three styles.

## Implementation and ecosystem

Beyond the interpreter itself, Perl's practical strength has long rested on the Comprehensive Perl Archive Network (CPAN), a large public repository of reusable Perl modules and documentation that has grown to hundreds of thousands of modules across tens of thousands of distributions contributed by a large community of authors. A "Modern Perl" style of development has grown up around this ecosystem, encouraging programmers to rely on CPAN modules and to take advantage of newer language features as a way of writing more maintainable and higher-quality Perl code.

## Uses and influence

Perl's regular-expression and string-parsing capabilities made it one of the most popular languages for writing Common Gateway Interface (CGI) scripts during the rapid growth of the World Wide Web in the mid-1990s, and modules such as CGI.pm reinforced that role. Outside of web scripting, Perl became a mainstay of Unix system administration, text processing, and general automation tasks, earning it the informal nickname "the Swiss Army chainsaw of scripting languages" in recognition of both its flexibility and its power. While its prominence in web development has since been overtaken by newer languages, Perl's historical role in popularizing practical, regular-expression-driven text processing in day-to-day system and web scripting remains a lasting part of its legacy.

## References

- [Wikipedia: Perl](https://en.wikipedia.org/wiki/Perl)

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory).
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory).
- `loadtest.pl`: a standalone load-generation script that forks the requested
  number of busy-looping processes.
- `hatena`: two scripts that post a URL to Hatena Bookmark, one with an empty
  summary and one with a comment read from stdin.
