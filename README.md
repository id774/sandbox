# Sandbox

This is a personal sandbox of small, throwaway code across many languages and
tools. It exists for trying things out, not for producing a maintained toolset.

## Contents

1. [About](#1-about)
2. [Directory Structure](#2-directory-structure)
3. [Design Philosophy](#3-design-philosophy)
4. [License](#4-license)

---

## 1. About

Unlike [`scripts`](https://github.com/id774/scripts), which is a curated,
policy-driven collection of reusable tools, this repository is an experimental
workspace: quick prototypes, language studies, and one-off snippets that may
never be finished or reused.

## 2. Directory Structure

Each top-level directory groups snippets by language or platform:

- `actionscript`, `bash`, `c`, `clojure`, `coffeescript`, `cpp`,
  `crystal`, `csharp`, `dart`, `dot`, `elixir`, `erlang`, `gauche`, `go`,
  `haskell`, `java`, `js`, `julia`, `kotlin`, `llvm`, `lua`, `nim`, `ocaml`,
  `perl`, `php`, `pig`, `play`, `python`, `r`, `rails`, `ruby`, `rust`,
  `scala`, `sh`, `sql`, `swift`, `tex`, `typescript`, `zig`, `zsh`

There is no shared structure or convention across directories; each one
reflects whatever was being explored at the time. The one exception is
`basics`, described below.

The largest directories carry their own README as an index of what they hold:
[`python`](python/README.md), [`ruby`](ruby/README.md), [`js`](js/README.md),
[`r`](r/README.md). [`sh`](sh/README.md) carries one for a different reason, to
state that what goes in it is POSIX.

### The `basics` Directory

Most language directories carry a `basics` subdirectory holding the same four
exercises, so that one language can be read against another:

| File | What it does |
| --- | --- |
| `fizzbuzz` | Prints FizzBuzz for 1 through 100. |
| `fibonacci` | Prints the first 20 Fibonacci numbers on one line. |
| `quicksort` | Sorts `5 3 8 4 2 7 1 10 9 6` and prints the result on one line. |
| `word_frequency` | Counts the words of a fixed sentence and prints them most frequent first, alphabetically within a tie. |

Every one of them prints exactly the same bytes in every language. Each is
written the way its own language would write it rather than as a transcription
of one common solution, which is the point of having them side by side. The
header comment of each file gives the command that runs or builds it.

`sh`, `bash`, and `zsh` each carry their own, written for that shell rather
than shared between them: the POSIX one has no array and leaves the counting to
`sort` and `uniq`, and the other two do not.

`dot`, `llvm`, `pig`, `sql`, `tex`, and the generated project trees have no
`basics`, since the set does not translate into them.

## 3. Design Philosophy

- This repository is intentionally a sandbox, not a release. Code here may be
  incomplete, broken, or written to test an idea rather than to be reused.
- [`doc/POLICY.md`](doc/POLICY.md) states the minimum asked of the code here: a
  one-line English header comment, no secrets, and a per-language convention
  kept as small as it can be. It is a floor, not a gate.
- The implementation policy of [`scripts`](https://github.com/id774/scripts) is
  not applied to the code, since experimenting with unconventional or
  unfinished approaches is the point. `doc/POLICY.md` lists which of its rules
  deliberately do not hold here.
- Its rules on naming, on branches and pull requests, and on documents do hold,
  and `doc/POLICY.md` sections 2.2, 3.1, and 3.2 state them. They govern how
  work is named, proposed, and filed rather than what a snippet may try. A
  shell script is a shell script here too.
- No `doc/VERSIONS` changelog is kept, since nothing here is packaged or
  released as a versioned deliverable; history lives in commit messages.

## 4. License

This repository is dual licensed under the [GPL version 3](https://www.gnu.org/licenses/gpl-3.0.html)
or the [LGPL version 3](https://www.gnu.org/licenses/lgpl-3.0.html), at your option.
For full details, please refer to the [LICENSE](doc/LICENSE) file. See also
[COPYING](doc/COPYING) and [COPYING.LESSER](doc/COPYING.LESSER) for the
complete license texts.
