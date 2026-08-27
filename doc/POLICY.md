# Sandbox Policy

This document states the minimum this repository asks of the code in it.

## 1. About This Document

This is a sandbox: prototypes, language studies, and one-off snippets written
to try an idea. Most of it was never finished, and some of it no longer runs
against current interpreters and libraries. That is the intended state, not a
backlog.

The rules here are therefore a floor, not a gate. Code that goes further than
they ask is welcome; code that only meets them is complete as it stands.

- They apply to what is written from now on. Nothing here is a reason to go
  back and revise a snippet that already exists.
- Working code is not assumed. An experiment that broke when its library moved
  on is kept as the record of what was tried.
- One rule about the code is absolute, and it is the one about secrets in
  section 2.3. The rest of what section 2 asks of a snippet is guidance.
- The rules section 3 inherits are not guidance. They govern how work is named,
  proposed, and filed rather than what a snippet may try, and being a sandbox
  is no reason to hold them loosely.

The companion repository [`scripts`](https://github.com/id774/scripts) carries
a full implementation policy in its `doc/POLICY`. That document governs a
maintained toolset and does not govern this one. Section 3 says which of its
rules deliberately do not apply here, and which of them do.

## 2. Common Minimum (All Languages)

### 2.1 Header Comment

- A file opens with one line of English, in that language's comment syntax,
  saying what it tries out.

```python
# Print the Fibonacci numbers below a limit given as an argument.
```

- One line is the target. Where the point of the snippet is not obvious from
  its code, a few more lines are better than a reader guessing.
- A project made of many files (`play/`, `rails/`, `actionscript/`, and the
  like) carries the comment on its entry point, not on every generated file.

### 2.2 English and Naming

- Comments and identifiers are written in English.
- Text that is itself the subject of the experiment is exempt. A snippet
  studying an encoding, a locale, or Japanese text processing holds whatever
  data it needs to hold.
- Name a thing by what it is, not by a part of it. A shell script is a shell
  script: the shell is the interpreter that runs it, and naming the script
  after the interpreter is as loose as calling a USB memory stick a USB. The
  same holds wherever a shorthand reaches for the interface, the format, or the
  container instead of the thing itself. This applies to the headers, the
  documents, and the commit messages as much as to the comments.
- That is the rule of `scripts/doc/POLICY` section 1.2.4, and it holds here
  unchanged. Nothing about a sandbox makes a loose name accurate.

### 2.3 No Secrets

This is the one rule that admits no exception.

- No API key, token, password, private key, or session cookie is committed,
  whether live, expired, or believed to be either.
- No real host name, account name, or mail address of a private system.
- Use an obvious placeholder instead: `YOUR_API_KEY`, `user@example.com`,
  `example.com`.
- A secret found in an existing snippet is removed as soon as it is noticed.
  That is the one case where old code is revised on sight.

### 2.4 Do No Damage

- A snippet that deletes, moves, or overwrites acts inside a path it was given
  or a temporary directory it made. It does not reach into the home directory
  or a system path on its own.
- Where the dangerous behaviour is the experiment, the header comment says so,
  as `c/escape_from_chroot.c` does. The rule asks that the risk be visible, not
  that the subject be avoided.

### 2.5 Attribution

- Code taken from an article, an answer, or a documentation example keeps the
  source URL in its header comment. It records where the idea came from and
  what version it was current for.

### 2.6 Directory Layout

- A top-level directory is named after a language or platform in lowercase,
  as that name is ordinarily written: `cpp`, `js`, `sh`, `r`, `tex`.
- Below it, subdirectories group by library or theme. Files directly under the
  top level are the short, single-topic exercises.
- Every top-level language or platform directory carries a `README.md` with a
  brief overview of the language, platform, or technology it represents.
- A directory large enough that its listing stops being an index uses the same
  README to say what is in it. `python`, `ruby`, `js`, and `r` do this.
- A directory whose contents are held to a constraint uses the same README to
  state that constraint where the files are rather than only in this document.
  `sh` does this because what goes in it is POSIX.
- Nothing in the code is shared across top-level directories. Each reflects
  whatever was being explored at the time, and the snippets are not brought
  into line with each other. The README requirement above and the
  cross-language exercise sets in section 2.8 are the deliberate exceptions.

### 2.7 Data Files

- Sample data a snippet reads may be committed when it is small and was written
  for that snippet. A few rows made up to give the code something to read is the
  scale intended.
- A dataset obtained from somewhere else is not committed, whatever its size or
  licence: a published corpus, a competition download, the sample data shipped
  with a library, or text lifted from a work. The snippet keeps reading the path
  it always read, and its header comment says where the file came from so that a
  reader can fetch it.
- A third-party library is not committed either. A snippet that needs one loads
  it from wherever that library is normally served, or its header comment gives
  the install command.
- Generated output is not committed: images, rendered documents, compiled
  objects, and build trees. `.gitignore` already excludes the common ones.

### 2.8 The Cross-Language Exercise Sets

Exercise sets are the one place where directories are deliberately brought into
line with each other, so that a language can be read against its neighbours. A
set is a subdirectory name carried by every language that can hold it, holding
the same exercises under that name in each.

Two sets exist, `basics` and `math`. A further set is added the same way, and
what this section asks holds of whichever set an exercise belongs to. What is
written here is the rule for a set; the exercises themselves and the output
they print are stated in the repository [README](../README.md), where a reader
meets them.

- Every exercise of a set prints identical output in every language, byte for
  byte.
- The data an exercise reads is fixed and held in the file. Nothing comes from
  an argument, from standard input, or from a clock or a random source, since
  none of those can be relied on to give the same bytes twice.
- Each is written the way its own language would write it, not as a
  transcription of one common solution. Matching output is the only thing held
  in common; pattern matching, laziness, generics, and allocation are meant to
  differ, and that difference is what a set is for.
- The file naming follows the language, not this document: `word_frequency.rs`
  where the language writes snake_case, `WordFrequency.kt` where it does not.
- The header comment of each file gives the command that runs or builds it.
- A language that a given exercise does not translate into simply does not
  carry it. `dot`, `llvm`, `pig`, `sql`, `tex`, and the generated project trees
  of section 4.6 carry neither set.
- A set may land in a directory name that already holds unrelated snippets, as
  `math` does under `python`, `ruby`, and `r`. The set is the files the README
  names, and a file name the set needs belongs to the set: `python/math/collatz.py`
  and `ruby/math/matrix.rb` held something else and now hold the exercise. What
  the directory holds under any other name is untouched.
- Nothing else in the repository is expected to line up this way. This section
  governs the exercise sets only.

`basics` prints the output below, and the text `word_frequency` counts is
`the quick brown fox jumps over the lazy dog the fox barks`:

| Exercise | Output |
| --- | --- |
| `fizzbuzz` | 100 lines, `Fizz` / `Buzz` / `FizzBuzz` in the usual places |
| `fibonacci` | `0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181` |
| `quicksort` | `1 2 3 4 5 6 7 8 9 10`, from the input `5 3 8 4 2 7 1 10 9 6` |
| `word_frequency` | `the 3`, `fox 2`, then the seven words that occur once, alphabetically |

`math` prints the output below. It is integer arithmetic throughout, so that no
language's float formatting can move the output, and no value it carries leaves
the range of a 64 bit integer:

| Exercise | Output |
| --- | --- |
| `sieve` | `2 3 5 7 ... 89 97`, the 25 primes below 100 on one line |
| `gcd_lcm` | four lines of `a b gcd lcm`, from the pairs `1071 462`, `270 192`, `17 5`, `120 36` |
| `collatz` | `871 179`, the longest Collatz sequence starting below 1000 and its length |
| `matrix` | the three rows of the product, then `1188`, its determinant |
| `pascal` | 10 lines, `1` through `1 9 36 84 126 126 84 36 9 1` |
| `modpow` | four lines of `base exponent modulus result`, the last of them `10 18 9999991 810000` |

## 3. What Does Not Apply, and What Does

The rules below come from `scripts/doc/POLICY`. They are listed so that they
are not reintroduced here by reflex. None of them applies to this repository.

- The structured header block (`Description`, `Author`, `Usage`, `Options`,
  `Requirements`, `Exit Status`, `Version History`). Section 2.1 asks for one
  line, and that is the whole requirement.
- Version numbers in files, and the `major.minor` rollover scheme.
- `doc/VERSIONS`, repository release versions, and Git tags. History lives in
  commit messages.
- The CLI conventions: `-h` and `-v`, usage output, and the exit code table
  (0, 1, 126, 127, sysexits).
- The `[INFO]` / `[WARN]` / `[ERROR]` log prefixes and the `log_info_time`
  helper.
- The `check_commands` and `check_sudo` helpers.
- The `etc/` configuration file conventions.
- A test suite. Nothing here needs a test, `run_tests.sh` has no counterpart,
  and a fix arrives without one.
- Python 3.1 backward compatibility, the standard-library-only rule, and the
  `find_pycompat.py` check.
- The licence line repeated in every file header. Section 6 covers the
  repository as a whole.

Not all of that document is set aside. Sections 3.1 and 3.2 below state the
parts that hold here, and the naming rule of its section 1.2.4 holds too, as
section 2.2 says. What is committed here may be a throwaway experiment; how it
is named, proposed, and filed is not.

### 3.1 Pull Requests and Branches

The branch and pull request rules of `scripts/doc/POLICY` section 1.8 hold in
this repository as they do in that one.

- One purpose to a pull request. A change noticed in passing goes on a branch
  of its own rather than enlarging the request already under review.
- A branch carrying one coherent change carries it as one commit. That commit
  is amended and force pushed with `--force-with-lease`, rather than gaining a
  further commit for each remark received.
- A branch is split into several commits only when it genuinely carries several
  independent changes.
- A revised branch is rewritten so that it reads as the change finally
  intended, and each revision is read against the base branch rather than
  against the revision before it.
- Conflicts with the base branch are resolved by rebasing onto it, so that no
  merge commit enters the branch.

The record of what was tried lives in the file that was committed, not in the
sequence of corrections that produced it.

### 3.2 Documents

The documentation rules of `scripts/doc/POLICY` sections 1.6.2 to 1.6.4 hold
here. They govern how a document is named and diffed, not what a snippet may
try, and a path published from a sandbox breaks just as badly as any other.

- A document written in Markdown takes `.md` when it is newly created. That is
  why the policy of this repository is `doc/POLICY.md` while the policy of
  `scripts`, written earlier, is `doc/POLICY`.
- `LICENSE`, `COPYING`, and `COPYING.LESSER` keep the extensionless names by
  which they are recognised.
- An existing document is never renamed to add or change an extension. A path
  here is a public URL that other repositories and pages outside them link to,
  and uniformity is not a reason to break one.
- The format of a document is decided by its name and its history, not by
  whether its text happens to parse as Markdown.
- `.gitattributes` gives `diff=markdown` to `*.md`, so that a diff hunk header
  names the section it falls in. That is a diff aid and nothing more: it changes
  neither a file's format nor how GitHub displays it. No file is given
  `linguist-language`.

## 4. Existing Languages

Each entry states only what is worth stating. Where nothing is listed beyond
section 2, nothing more is asked.

### 4.1 Python

- Any Python 3 version. f-strings, type hints, `pathlib`, and `subprocess.run`
  are all fine.
- Third-party libraries are the point of most of these directories. Import
  whatever the experiment is about.
- Four-space indentation.
- No `main() -> int` entry point and no `sys.exit(main())` are required. A
  script that is a sequence of statements stays one.
- A file meant to be run directly takes `#!/usr/bin/env python3`. The existing
  `#!/usr/bin/env python` lines stay as they are.

### 4.2 Ruby

- Any Ruby version, and any gem.
- Two-space indentation.
- `#!/usr/bin/env ruby` for a new file. The `#!/opt/ruby/current/bin/ruby` and
  similar lines already here record the environment of their time and stay.

### 4.3 Shell Script

- Three directories hold shell scripts, each named after the shell its scripts
  are written for: `sh` for the POSIX shell, `bash` for Bash, and `zsh` for the
  Z shell. A script goes in the directory of the shell it needs, not the one
  whose features it happens to avoid.
- POSIX `sh` is not required of a snippet. Reaching for Bash or Zsh is a choice
  of directory, not a concession.
- The shebang matches the shell the script actually needs: `#!/bin/sh` only for
  one that holds to POSIX, `#!/bin/bash` for one using arrays, `[[ ... ]]`, or
  `local`, and `#!/bin/zsh` for one using zsh parameter expansion flags or its
  array indexing.
- `.sh` for a POSIX or Bash script, `.zsh` for a Zsh script.
- What is added to `sh` from now on is POSIX and carries `#!/bin/sh`.
  [`sh/README.md`](../sh/README.md) states that at the directory itself, and
  `sh/basics` holds to it. The Bash scripts already under `sh` were written
  before the split; they keep their shebangs and their paths, as section 1 says
  of anything already written.

### 4.4 JavaScript

- A snippet should load as it stands, in a browser or under Node.js, without a
  build step. Where one is unavoidable, the header comment gives the command.

### 4.5 C and C++

- Where the build command is not obvious, the header comment gives it, such as
  `cc -o socket socket.c -lpthread`.

### 4.6 Generated Project Trees

- `java`, `scala`, `play`, `rails`, and `actionscript` contain trees produced
  by a framework or an IDE. Those generated project trees, their layout,
  formatting, and generated files are left as generated. The top-level
  `README.md` required by section 2.6 is repository documentation and does not
  authorize changes inside a generated project tree.
- What is left as generated is the source the tool wrote. Build output under
  such a tree is not exempt from section 2.7, and neither is the launcher or the
  library a scaffold happened to copy in.

### 4.7 Everything Else

Header comment syntax, and the formatting each follows.

| Language | Directory | Comment | Formatting |
| --- | --- | --- | --- |
| R | `r` | `#` | Community default |
| Haskell | `haskell` | `--` | `ormolu` or `stylish-haskell` defaults |
| Erlang | `erlang` | `%` | `erlfmt` defaults |
| Scheme (Gauche) | `gauche` | `;;` | Two-space, standard Lisp indentation |
| Go | `go` | `//` | `gofmt` |
| Lua | `lua` | `--` | Community default |
| Perl | `perl` | `#` | `perltidy` defaults |
| PHP | `php` | `//` | PSR-12 |
| CoffeeScript | `coffeescript` | `#` | Two-space |
| LLVM IR | `llvm` | `;` | As emitted |
| SQL | `sql` | `--` | Community default |
| DOT | `dot` | `//` | Community default |
| Pig Latin | `pig` | `--` | Community default |
| Rust | `rust` | `//` | `rustfmt` |
| TypeScript | `typescript` | `//` | `prettier` |
| Kotlin | `kotlin` | `//` | `ktlint` |
| Swift | `swift` | `//` | `swift-format` |
| C# | `csharp` | `//` | `dotnet format` |
| Elixir | `elixir` | `#` | `mix format` |
| Clojure | `clojure` | `;;` | Standard Lisp indentation |
| Julia | `julia` | `#` | `JuliaFormatter` |
| Zig | `zig` | `//` | `zig fmt` |
| Nim | `nim` | `#` | `nimpretty` |
| Crystal | `crystal` | `#` | `crystal tool format` |
| OCaml | `ocaml` | `(* *)` | `ocamlformat` |
| Dart | `dart` | `//` | `dart format` |

A language that moves fast enough for a snippet to stop compiling has the
version it was written against named in the header comment, as `zig/basics`
does.

## 5. Adding a Language

1. Create a top-level directory named after the language in lowercase, as the
   language is ordinarily written. Spell out a name that a path cannot carry:
   `csharp`, not `c#`. Prefer the full name to an abbreviation, unless the
   abbreviation is what the language is called: `typescript`, not `ts`, but
   `js` and `cpp` as they already stand.
2. Follow section 2. Nothing further is asked.
3. Format with the language's own standard tool at its defaults. Do not invent
   a convention for this repository.
4. Add the directory to the language list in `README.md`.

Likely candidates, so that the question is already answered when one arrives:

| Language | Directory | Comment | Formatting |
| --- | --- | --- | --- |
| Raku | `raku` | `#` | Community default |
| PowerShell | `powershell` | `#` | Community default |
| Emacs Lisp | `elisp` | `;;` | Standard Lisp indentation |
| Common Lisp | `lisp` | `;;` | Standard Lisp indentation |
| Terraform | `terraform` | `#` | `terraform fmt` |
| Dockerfile | `dockerfile` | `#` | Community default |
| Makefile | `makefile` | `#` | Tabs, as Make requires |
| WebAssembly | `wasm` | `;;` | `wat2wasm` conventions |

A language not listed follows its own community's standard. The table saves a
decision; it does not restrict the list.

## 6. License

This repository is dual licensed under the GPL version 3 or the LGPL version 3,
at the user's option. See [LICENSE](LICENSE), [COPYING](COPYING), and
[COPYING.LESSER](COPYING.LESSER).

Individual files carry no licence header. The repository-wide terms cover them.
Code brought in from elsewhere keeps whatever notice it arrived with, alongside
the source URL that section 2.5 asks for.
