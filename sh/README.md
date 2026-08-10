# POSIX Shell Script

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

## Notes

Snippets target whichever shell and tool versions were current when they were
written, so some no longer run as is. See the repository
[README](../README.md) for the sandbox policy.
