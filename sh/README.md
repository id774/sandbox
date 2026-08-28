# POSIX Shell Script

## Overview

The subject of this directory, per repository policy, is the POSIX `sh` shell language: the standardized command and scripting language specified for `sh` by POSIX, rather than any single program that implements it. That language traces its lineage directly to the Bourne shell, whose syntax and constructs it codifies, and it is built around running commands, connecting them with pipelines, redirecting their input and output, expanding variables and other tokens, and sequencing work with control structures. Because it is a specification rather than a particular executable, POSIX `sh` is deliberately conservative, leaving out the various extensions that shells such as Bash and Zsh layer on top of the same Bourne-derived core.

## History

The Bourne shell was written by Stephen Bourne at Bell Labs and shipped as part of Version 7 Unix in 1979, where it replaced the earlier Thompson shell written by Ken Thompson for the first versions of Unix. The Thompson shell was a comparatively simple command interpreter without the programming constructs needed for substantial scripts, and Bourne's shell addressed that gap by adding features such as control-flow constructs, variables, and here-documents, making it practical to write real programs in the shell rather than only issue interactive commands. The Bourne shell then spread as the standard shell across commercial Unix systems, and its syntax and behavior became the reference point when the POSIX committee later defined a standardized shell command language: the resulting `sh` specification codified the Bourne shell's constructs so that conforming scripts would behave consistently across compliant systems, rather than tying the language to Bell Labs' original implementation.

## Language design and characteristics

A POSIX `sh` script is built from commands invoked by name, connected where useful into pipelines that pass one command's output to the next command's input, and combined with redirection operators that route input and output to and from files. The language provides several forms of expansion, including parameter expansion for variables, command substitution for capturing another command's output, and word splitting and filename expansion, all of which happen before a command is run. Control structures such as `if`, `while`, `until`, `for`, and `case` give scripts conditional and repeated execution, and shell functions allow a script to group commands under a name for reuse. Portability, in this context, means that a script written strictly to the POSIX `sh` specification is expected to behave the same way under any conforming implementation, since it relies only on the constructs the standard defines rather than on behavior specific to one shell.

## Implementation and ecosystem

POSIX `sh` is a language specification, not a program, and several different implementations provide it in practice. Bash, the GNU Bourne-Again Shell, implements POSIX `sh` behavior alongside a substantial set of its own extensions and is commonly installed as an interactive login shell; dash, a smaller and more minimal shell, is used on some systems specifically as `/bin/sh` because it sticks closely to the standardized language without the extra features; and the Korn shell, another descendant of the Bourne shell, likewise implements the POSIX language while adding capabilities of its own. Treating "the language" and "an implementation" as distinct matters here: a script that happens to work under Bash's `/bin/sh` is not necessarily POSIX-conformant, because Bash recognizes constructs the standard does not require, and the same script can fail under a stricter implementation such as dash.

## Uses and influence

Because POSIX `sh` is the shell language guaranteed to be available, in some form, on essentially every Unix-like system, it remains the language of choice for scripts that need to run unmodified across many machines and distributions without assuming a particular shell is installed as `/bin/sh`. That same portability requirement is also why the language deliberately excludes conveniences that Bash and Zsh add, such as arrays, the `[[ ... ]]` conditional syntax, `local` variables, and compound assignment operators like `+=`: including them would tie scripts to a specific implementation rather than to the standard, defeating the purpose of writing to POSIX `sh` in the first place.

## References

- [Wikipedia: Bourne shell](https://en.wikipedia.org/wiki/Bourne_shell)

POSIX shell script experiments. What is placed here holds to POSIX and runs
under a plain `/bin/sh`.

## The Rule for This Directory

- A script added here from now on is POSIX, and carries `#!/bin/sh`.
- POSIX is what the directory name promises. A script that wants an array,
  `local`, `[[ ... ]]`, `+=`, or an associative array is not a POSIX shell
  script, and belongs in [`bash`](../bash) or [`zsh`](../zsh) instead.
- `dash` is the check worth running, since `/bin/sh` is not Bash on every
  system: `dash basics/quicksort.sh`.

## What Predates the Rule

`batch.sh`, `chatgpt_export.sh`, `shebang.sh`, and `shellshock.sh` carry
`#!/bin/bash` and were written before the shell directories were split. They
keep their shebangs and their paths. The rule applies to what is added from now
on, as `doc/POLICY.md` section 1 says of anything already written.

## Layout

- `basics`: the cross-language exercise set, described in the repository
  [README](../README.md#the-basics-directory). Its four exercises print the
  same output as every other `basics` directory, and the POSIX constraint is
  visible in how they reach it: the Fibonacci numbers accumulate in one
  variable for want of an array, the quicksort keeps each call's pivot off the
  next through the subshell of a command substitution for want of `local`, and
  the word count goes to `sort` and `uniq` for want of an associative array.
- `math`: the second exercise set, described in the repository
  [README](../README.md#the-math-directory). The same constraint shows again:
  the sieve rebuilds a candidate string once per prime for want of an array of
  flags, and the matrix pastes its row and column into a variable name through
  `eval` for want of a subscript.
- `hadoop`, `shunit2`: scripts written against one particular tool.
- `git_reset_history.sh`: the Git commands that reduce a repository's history to
  one Initial commit without deleting the repository. It rewrites history, so it
  belongs against a disposable repository only.
- `llama_kv_cache_benchmark.sh`: the two `llama-bench` runs that compare an F16
  KV cache with a Q8_0 one.

## Notes

Snippets target whichever shell and tool versions were current when they were
written, so some no longer run as is. See the repository
[README](../README.md) for the sandbox policy.
