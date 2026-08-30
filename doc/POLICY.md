# Sandbox Policy

This document states the repository-wide rules that apply when code,
documentation, or data is added to or changed in this repository. It does not
describe what the repository currently contains; that is the responsibility of
[the repository README](../README.md) and the README of each top-level
directory. Adding, removing, or changing a language, a platform, or an
exercise does not by itself require this document to change.

This policy is self-contained. It does not defer to, inherit from, or require
reading the policy of any other repository to be understood.

## 1. Purpose and Scope

This is a sandbox: a personal workspace for prototypes, language studies, and
one-off experiments, not a maintained, production toolset. The rules below are
a floor for what is added to it, not a gate that existing content is expected
to pass. They apply to a repository change made from now on; they are not a
reason, by themselves, to go back and revise something already committed.

## 2. Core Principles

### 2.1 Experimental by Design

The repository exists for trying an idea out. Production readiness,
reusability, ongoing maintenance, and staying current with a dependency's
latest release are not required of what is added here. Code that is
incomplete, that only partly works, or that uses an older idiom or API is not,
by itself, a policy violation.

### 2.2 Preserve Historical Experiments

Existing content is a record of what was tried and when. A snippet is not
rewritten, upgraded, or removed only because it is old, no longer runs against
a current interpreter or library, uses a deprecated interface, or no longer
matches current practice in its language. Section 7.3 states the one
exception, for security and privacy.

### 2.3 Minimal Changes

A change touches only what its stated purpose requires. Unrelated refactoring,
reformatting, modernization, or cleanup does not ride along with it, even when
it would be a plausible change on its own.

### 2.4 Language-Native Conventions

The repository does not impose one coding style across every language it
holds. Each language, platform, and tool follows its own established
convention and, where one exists, its own standard formatter, at that
formatter's defaults. This document does not catalogue those conventions or
formatters; a directory's README may note one where it is relevant to that
directory.

## 3. Repository Structure

### 3.1 Top-Level Organization

A top-level directory is, as a rule, organized around a language, a platform,
or a technology. What top-level directories currently exist is stated in the
repository README, not in this document, so that adding or removing one does
not require a policy change.

### 3.2 Naming

A new directory, file, or other named thing takes a name that identifies it
accurately and stably, in the way it is ordinarily referred to. A name reaches
for what a thing is, not for a part of it, such as the interface it is
accessed through, the format it happens to be written in, or the container it
ships in; conflating one of those with the thing itself produces a name that
is technically wrong even where it is common shorthand. This applies equally
to directory and file names, to identifiers and comments within a file, and to
commit messages.

An existing path is not renamed only to bring it into line with a naming
convention adopted later. A path may be linked to from outside the repository,
and renaming breaks that link for no benefit to the repository itself.

Comments and identifiers are written in English, except where the text itself
is the subject of the experiment, such as a snippet studying an encoding, a
locale, or non-English text processing; such a snippet holds whatever data the
experiment needs.

### 3.3 Local Structure

There is no requirement that every top-level directory share the same
internal layout. A directory may hold small, standalone files directly, group
related work into subdirectories by library or theme, or do both; the choice
is whatever fits what that directory holds. Section 6 states the one
deliberate exception, where comparable experiments are placed the same way
across languages so that they can be read against each other.

### 3.4 Generated Project Trees

Where a top-level directory holds a project tree produced by a framework,
build tool, or IDE generator, that tree's own layout, formatting, and
generated files are left as the tool produced them. This document's
documentation and naming rules do not require restructuring a generated tree
to match them, though they still apply to documentation the repository itself
adds alongside it. Section 9 covers build output within such a tree.

## 4. Source Code

### 4.1 Purpose and Context

A reader should be able to tell what a snippet is trying out. Where that is
not obvious from the code itself, the necessary context, such as what problem
it explores or what it demonstrates, is recorded in the file or in
documentation near it. A project made of many files carries this context on
its entry point rather than repeating it in every generated or supporting
file, and a generated file or generated project tree, as described in Section
3.4, is not required to carry a repository-authored header of its own.

### 4.2 Execution Requirements

Where how a snippet is run, built, or invoked is not self-evident from its
name, its language, or its location, that information is recorded in the file
or in documentation near it, so that a reader does not have to guess it.

### 4.3 Language Conventions

Source code follows the established convention of the language, platform, or
tool it is written for, as Section 2.4 states. This document does not require
a uniform style across languages, and it does not catalogue per-language
formatters, comment syntax, or style rules; where such detail is useful to a
reader, it belongs in that directory's own README, per Section 5.2.

### 4.4 Dependencies

A third-party library or dependency a snippet needs is not vendored into the
repository without a specific reason tied to that snippet's purpose; ordinary
use loads it the way that language or platform normally serves it, or records
how to obtain it. This document does not set a package-manager or
version-support policy common to every language.

## 5. Documentation

### 5.1 Repository README

The root README describes the repository's purpose, its current top-level
directories and what each one is for, its current cross-language experiment
sets and the concrete exercises they contain, and how to navigate it. It is
the current inventory of what the repository holds.

### 5.2 Directory README

Each top-level directory's README describes the language, platform, or
technology that directory represents, what the directory itself contains, and
any constraint local to that directory.

### 5.3 Local Constraints

A constraint that applies only within one directory, such as a language
subset a directory's contents are held to, is stated in that directory's own
README, where a reader working in that directory will see it. Such a local
constraint may narrow what is written in that directory beyond what this
document asks; it may not relax a rule this document states.

### 5.4 Single Source of Truth

A concrete specification, such as what a given exercise computes, what input
it uses, or what output it produces, has exactly one authoritative statement,
in the README responsible for it under Sections 5.1 and 5.2. This document
does not restate or duplicate that detail; it states only the rule that such
detail belongs to a README and not to this document.

## 6. Cross-Language Experiments

The repository may place comparable exercises across multiple language or
platform directories, so that the same problem can be read against a
different language's idioms. Where it does, the following applies:

- The exercises in a given set are placed under the same subdirectory name in
  every language directory that carries that set.
- The same exercise means the same thing, and produces a deterministic
  result, in every language that carries it.
- Each language implements it in that language's own idiom rather than as a
  transcription of another language's solution; matching results are what is
  held in common, not matching code.
- A language or platform whose nature does not fit a given exercise is not
  required to carry it.

Which sets currently exist, their exercises, and the concrete input and
expected output of each are stated in the repository README, per Section 5.1,
and are not repeated here.

## 7. Security and Privacy

### 7.1 Secrets

No API key, password, access token, private key, or session credential, live,
expired, or of unknown status, is committed to this repository.

### 7.2 Private Information

No private infrastructure information, such as a real internal host name or
network address, and no personal information, that is not intended for public
disclosure, is committed to this repository. Where a snippet needs an example
of such a value, it uses an obvious placeholder instead.

### 7.3 Existing Content

Where a secret or private information described in Sections 7.1 or 7.2 is
found in existing content, it is removed on sight. This is the one exception
to Section 2.2: preserving the historical record does not extend to
preserving a credential or private information that should never have been
committed.

## 8. Safety

A snippet whose subject is inherently destructive, such as one that deletes,
overwrites, or otherwise damages data, is not prohibited on that basis alone.
It does, however, act on a scope it was deliberately given, such as a path
passed to it or a directory it creates for itself, rather than reaching into a
home directory or a system path on its own initiative. Where causing damage
is the point of the experiment, that is made evident to a reader, such as
through the context required by Section 4.1, rather than left for a reader to
discover by running it.

## 9. Data and Generated Artifacts

A small sample of data may be committed where it was written specifically for
the snippet that reads it. An external dataset or other third-party material
is not copied into the repository without a specific reason, given the
redistribution rights, size, and origin such material carries; a snippet that
needs one instead records where to obtain it.

Build output, caches, temporary files, and other generated artifacts are not
committed, except where the generated artifact is itself the subject of the
experiment. This document does not enumerate what is excluded; the
repository's ignore configuration does that.

## 10. Attribution and License

Content adapted from an external article, answer, or documentation example
credits its source and respects any third-party license it carried.

This repository is dual licensed under the GPL version 3 or the LGPL version
3, at the user's option. See [LICENSE](LICENSE), [COPYING](COPYING), and
[COPYING.LESSER](COPYING.LESSER). This document does not change those terms.

## 11. Changes

A change to this repository, whether to code, documentation, or data, serves
one coherent purpose and stays within the scope that purpose requires, per
Section 2.3. It does not fold in unrelated cleanup, and it leaves
documentation consistent with what it changes in the code, and code consistent
with what it changes in the documentation.

## 12. Release and Maintenance

This repository is not maintained as a packaged release. It does not carry a
repository-wide version number, and a change to it is not a reason to
introduce one. Backward compatibility is not offered as a general guarantee,
automated test coverage is not required of every snippet, and staying
compatible with a dependency's current version is not an ongoing obligation.
None of this permits a documentation change to alter what existing, executable
code actually does.
