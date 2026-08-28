# Zsh

## Overview

Zsh, or the Z shell, is a Unix shell that functions both as an interactive command-line environment and as a scripting language. It is built on the same general model as the Bourne shell and remains compatible with much of its syntax, but it extends that foundation with a substantially larger set of interactive conveniences and scripting features than the plain Bourne shell provides.

## History

Zsh was created by Paul Falstad in 1990 while he was a student at Princeton University. According to accounts of its origin, Falstad named the shell after a teaching assistant, Zhong Shao, whose account login was "zsh," which he thought made a fitting name for a new shell. Since its creation, zsh has continued to be developed as free software, growing in features over time while remaining broadly compatible with the Bourne shell family it descends from.

## Language design and characteristics

Zsh preserves most of the Bourne shell's core syntax and behavior, which allows many existing Bourne-style scripts to run under it largely unmodified, while also drawing on features from other shells, notably the Korn shell (ksh) and the C shell derivative tcsh, and to a lesser extent the rc shell. From these influences, and its own extensions, zsh supports capabilities such as arrays, more elaborate forms of parameter expansion than the Bourne shell offers, and extended pattern globbing that can match file names in more expressive ways than standard shell globs. Because it serves both roles, zsh is used interactively at the command line in much the same way as bash, while its scripting facilities are also complete enough to write substantial shell scripts and functions.

## Implementation and ecosystem

Interactively, zsh is particularly known for features such as programmable command completion, which can be customized extensively to complete commands, options, and arguments intelligently; a flexible, themeable prompt system; and rich command history handling. In its default configuration, zsh deviates from the POSIX specification for the shell language in several respects, such as not performing implicit word splitting and globbing on unquoted parameter expansions the way POSIX-conformant sh behavior requires, even though it can be switched into modes that emulate other shells more closely. These differences, combined with the features carried over from ksh and tcsh, are what most distinguish zsh from both a strictly POSIX-compliant sh and from bash, which historically has hewed closer to POSIX behavior while adding its own more limited set of extensions.

## Uses and influence

Zsh is widely used as an interactive login and command shell, valued particularly for its completion system and customization options, and it became the default interactive shell on macOS starting with macOS Catalina in 2019, replacing the outdated GPLv2-licensed version of bash that Apple had shipped previously. Outside of macOS, it also remains a popular alternative shell on Linux and other Unix-like systems for users who want its interactive features while retaining broad compatibility with Bourne-style scripting.

## References

- [Wikipedia: Z shell](https://en.wikipedia.org/wiki/Z_shell)
