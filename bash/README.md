# Bash

## Overview

Bash, short for "Bourne-Again SHell," is a Unix shell and command language that serves two roles at once: an interactive command interpreter through which a user types commands at a prompt, and a scripting language in which those same commands can be assembled into files and executed non-interactively. Its name is a pun acknowledging its lineage from the earlier Bourne shell, whose command language and overall structure it is built to be compatible with while extending it in numerous ways. Bash is one of the most widely deployed shells in Unix-like computing, functioning as the primary interface between users, scripts, and the underlying operating system on a large share of Linux and other Unix-like systems.

## History

Bash was created in 1989 by Brian Fox for the GNU Project, conceived as a completely free software alternative to the Bourne shell and to other, often proprietary, Unix shells of the era, and it was released as a public beta in June of that year. Fox served as the software's original author and its primary maintainer through the project's early years, and its development has continued under the auspices of the GNU Project with the backing of the Free Software Foundation. Bash's design draws directly on the Bourne shell, whose own history traces back to Stephen Bourne's work at Bell Labs beginning in 1976 and its release in 1979 as part of Version 7 Unix, where it replaced the earlier Thompson shell. Beyond the Bourne shell, Bash also incorporates ideas and features found in the C shell (csh) and the Korn shell (ksh).

## Language design and characteristics

As both an interactive shell and a scripting language, Bash lets the same syntax be typed at a live prompt or saved into a script file and run as a program, with control structures, functions, and variables available in either mode. Bash is designed to be broadly compatible with the POSIX shell command language, but it also implements a considerable number of extensions beyond what POSIX specifies, so that a script relying on these extensions is a valid Bash script without necessarily being a portable POSIX `sh` script. Among these extensions are indexed and associative arrays, whereas POSIX itself defines only the single implicit array of positional parameters; an extended `[[ ... ]]` conditional test construct; and richer forms of parameter, brace, and command substitution. Bash also provides job control, letting a user move commands between foreground and background execution and manage the signals associated with that control in a manner modeled on the interface the Korn shell established and that POSIX later specified. Interactive use is further supported by command history, allowing earlier commands to be recalled and re-executed, and by programmable command-line completion, which lets the shell expand partial input into full commands, filenames, or arguments.

## Implementation and ecosystem

Bash is closely associated with the GNU Project and is commonly installed as the default login and scripting shell across a large number of Linux distributions, where it functions as the standard shell through which users and system scripts interact with the operating system. Within the broader Unix shell landscape, Bash is described as the dominant shell used on Linux, even though alternative shells such as Zsh are also in use and have found particular niches of their own.

## Uses and influence

Bash's dual nature as an interactive shell and a scripting language has made it central to everyday command-line use and to the automation of system administration tasks on Unix-like systems, and its extensions to the POSIX shell language are extensive enough that Wikipedia describes the list of Bash-only features as considerable. Its status as a default shell has shifted over time on some systems: on Apple's operating system, the default shell for new user accounts changed to Bash beginning with Mac OS X 10.3, but with the release of macOS Catalina (10.15) in 2019, Apple changed the default login shell to Zsh instead, and running the older, GPLv2-licensed version of Bash still bundled with macOS interactively now displays a warning message by default.

## References

- [Wikipedia: Bash (Unix shell)](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
