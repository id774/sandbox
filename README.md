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

Repository-wide documentation lives in `doc/`. The remaining top-level
directories group experiments by language, platform, or technology:

- `actionscript`, `bash`, `c`, `clojure`, `coffeescript`, `cpp`,
  `crystal`, `csharp`, `dart`, `dot`, `elixir`, `erlang`, `gauche`, `go`,
  `haskell`, `java`, `js`, `julia`, `kotlin`, `llvm`, `lua`, `nim`, `ocaml`,
  `perl`, `php`, `pig`, `play`, `python`, `r`, `rails`, `ruby`, `rust`,
  `scala`, `sh`, `sql`, `swift`, `tex`, `typescript`, `zig`, `zsh`

There is no shared structure for the snippets across directories; each one
reflects whatever was being explored at the time. The shared README overview
requirement and the cross-language exercise sets, `basics` and `math`, are the
deliberate exceptions.

Every top-level language or platform directory carries a `README.md` with a
comprehensive overview of the language, platform, or technology it represents,
covering its history, defining characteristics, implementation or execution
model, ecosystem or standardization where applicable, and principal uses. The
larger directories [`python`](python/README.md), [`ruby`](ruby/README.md),
[`js`](js/README.md), and [`r`](r/README.md) also use that README as an index
of what they hold. [`sh`](sh/README.md) additionally states the POSIX
constraint that applies there.

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

### The `math` Directory

The same language directories carry a `math` subdirectory holding the same six
exercises. They ask one step more of a language than `basics` does, and what
they ask is arithmetic rather than string handling:

| File | What it does |
| --- | --- |
| `sieve` | Prints the primes below 100, struck out by the sieve of Eratosthenes. |
| `gcd_lcm` | Prints the greatest common divisor and least common multiple of four fixed pairs, by Euclid's algorithm. |
| `collatz` | Prints the start below 1000 whose Collatz sequence is the longest, and how many terms that sequence has. |
| `matrix` | Multiplies two fixed 3x3 integer matrices and prints the product, then its determinant. |
| `pascal` | Prints the first 10 rows of Pascal's triangle. |
| `modpow` | Prints the modular power of four fixed triples, by repeated squaring. |

They hold to the rule `basics` holds to: the same bytes out of every language,
nothing read from an argument or from standard input, and the data fixed in the
file. Every one of them is integer arithmetic throughout, so that no language's
float formatting can move the output, and no value it carries leaves the range
of a 64 bit integer.

`python`, `ruby`, and `r` had a `math` directory of unrelated snippets before
the set arrived. The six files named above are the set; the rest of what those
directories hold is what it always was.

## 3. Design Philosophy

- This repository is intentionally a sandbox, not a release. Code here may be
  incomplete, broken, or written to test an idea rather than to be reused.
- [`doc/POLICY.md`](doc/POLICY.md) states the repository-wide rules asked of
  what is added here: how the repository is organized and named, what source
  code and documentation are expected to convey, security and privacy, safety,
  and how a change is scoped. It is a floor, not a gate, and it is unrelated to
  the policy of any other repository.
- No `doc/VERSIONS` changelog is kept, since nothing here is packaged or
  released as a versioned deliverable; history lives in commit messages.

## 4. License

This repository is dual licensed under the [GPL version 3](https://www.gnu.org/licenses/gpl-3.0.html)
or the [LGPL version 3](https://www.gnu.org/licenses/lgpl-3.0.html), at your option.
For full details, please refer to the [LICENSE](doc/LICENSE.md) file. See also
[COPYING](doc/COPYING) and [COPYING.LESSER](doc/COPYING.LESSER) for the
complete license texts.
