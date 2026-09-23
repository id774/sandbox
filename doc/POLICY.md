# Sandbox Policy

This document states the repository-wide implementation and maintenance rules
that apply when code, documentation, or data is added to or changed in this
repository. It does not describe what the repository currently contains; that
is the responsibility of [the repository README](../README.md) and the README
of each top-level directory. Adding, removing, or changing a language, a
platform, or an exercise does not by itself require this document to change.

This policy is self-contained. It does not defer to, inherit from, or require
reading the policy of any other repository to be understood. Rules that are
common across repositories are stated here in the form that applies to this
repository; repository-specific rules remain here rather than being replaced
by cross-repository references.

## 0. Governing Principle

**Simplicity is robustness.**

This is the governing principle for every rule below. It does not authorize
dropping required behavior, compatibility, or safety; it requires meeting them
with the least complexity justified by the actual requirement.

Complexity is itself a source of failure, compatibility risk, operational
risk, and maintenance cost. Do not add a branch, state variable, helper,
abstraction, dependency, retry, fallback, validation, or defensive check
unless it is required by the specification or addresses a realistic failure
mode with meaningful operational consequence. Do not re-check a condition
already guaranteed by a preceding successful operation or an established
invariant.

When two designs satisfy the same requirements, choose the one with less
control flow, less state, fewer dependencies, and fewer moving parts.
Simplicity is judged by necessary concepts and behavior, not by line count
alone.

## 1. General Policy

### 1.1 Purpose and Scope

This is a sandbox: a personal workspace for prototypes, language studies, and
one-off experiments, not a maintained, production toolset. The rules below are
a floor for what is added to it, not a gate that existing content is expected
to pass. They apply to a repository change made from now on; they are not a
reason, by themselves, to go back and revise something already committed.

### 1.2 Decision Priorities and Maintainer Judgment

Where more than one implementation or maintenance choice satisfies the stated
purpose, judge the alternatives in this order:

1. Preserve the stated scope and the intended, valid observable behavior that
   the change was not asked to alter.
2. Preserve safety and privacy: do not destroy, overwrite, expose, or publish
   anything the change was not asked to touch.
3. Prefer the simpler implementation with fewer dependencies, moving parts,
   side effects, and operational assumptions.

The experimental nature of this repository does not turn an unrelated behavior
change into part of a task. At the same time, this repository does not promise
general backward compatibility for every historical experiment; Section 2.7
defines that maintenance boundary.

Where this policy and the applicable local documentation leave more than one
valid choice, an explicit maintainer decision settles that choice. A general
best practice, a convention from another repository, or a newer technique does
not override that decision.

### 1.3 Change Discipline and Observable Behavior

A change touches only what its stated purpose requires. Unrelated refactoring,
reformatting, modernization, cleanup, renaming, feature work, or documentation
rewriting does not ride along with it, even when it would be a plausible change
on its own.

Documentation work, policy work, review, diagnostics, cleanup, or another task
whose stated scope does not include an implementation change does not expand
into one merely because an implementation improvement is noticed.

When the task does not require a behavior change, preserve the intended and
valid existing observable behavior of the affected content. That includes, as
applicable, control flow, processing order, continuation after failure, side
effects, output, exit status, options, defaults, configuration semantics, file
layout, and generated results.

A clear defect is not protected merely because the current code exhibits it.
Correct it when correcting that defect is part of the stated purpose. Finding a
defect while doing unrelated work does not by itself add its correction to the
current scope.

When an authorized implementation change alters behavior or an interface that
the repository documents, update the directly affected documentation in the
same change. This requirement does not authorize unrelated documentation
cleanup. Likewise, changing documentation does not silently change executable
behavior; if the document and implementation disagree, determine which is
wrong from the repository's stated purpose and local source of truth, and
change only the side the task requires.

### 1.4 Repository-Wide and Local Rules

This policy is the repository-wide floor. A rule that applies only to one
language, platform, technology, generated project, experiment, or directory is
kept with that scope, normally in the responsible README or in the source when
the constraint is inseparable from the source itself.

A local rule may narrow what is permitted in its scope. It does not relax a
repository-wide safety, privacy, attribution, or change-discipline rule stated
here.

Do not impose one implementation style mechanically across different
languages, platforms, or tools. Apply the native convention and the local
contract unless doing so conflicts with a repository-wide rule.

### 1.5 Naming, Comments, and Language

A new directory, file, identifier, or other named thing takes a name that
identifies it accurately and stably, in the way it is ordinarily referred to.
Name a thing by what it is, not by one interface, representation, format, or
container it happens to use.

An existing path is not renamed only to bring it into line with a convention
adopted later. A path may be linked to from outside the repository, and
uniformity alone does not justify breaking that path.

Comments and identifiers are written in English, except where non-English text
is itself the subject or data of the experiment, such as an encoding, locale,
natural-language, or text-processing example.

A comment preserves a reason, constraint, non-obvious intent, or decision that
a later change could otherwise undo. Do not use comments merely to restate code
whose operation is already evident.

### 1.6 Documentation

#### 1.6.1 Repository README

The root README describes the repository's purpose, its current top-level
directories and what each one is for, its current cross-language experiment
sets and the concrete exercises they contain, and how to navigate it. It is the
current inventory of what the repository holds.

#### 1.6.2 Directory README

Each top-level directory organized around a language, platform, or technology
has a README that describes what that directory represents, what the directory
itself contains, and any constraint local to that directory.

#### 1.6.3 Local Constraints

A constraint that applies only within one directory, such as a language subset
a directory's contents are held to, is stated in that directory's own README,
where a reader working in that directory will see it. Such a local constraint
may narrow what is written in that directory beyond what this document asks;
it may not relax a repository-wide rule this document states.

#### 1.6.4 Single Source of Truth

A concrete specification, such as what a given exercise computes, what input
it uses, or what output it produces, has exactly one authoritative statement,
in the README responsible for it under Sections 1.6.1 and 1.6.2. This document
does not restate or duplicate that detail; it states only the rule that such
detail belongs to a README and not to this document.

### 1.7 Security and Privacy

#### 1.7.1 Secrets

No API key, password, access token, private key, or session credential, live,
expired, or of unknown status, is committed to this repository.

#### 1.7.2 Private Information

No private infrastructure information, such as a real internal host name or
network address, and no personal information that is not intended for public
disclosure, is committed to this repository. Where a snippet needs an example
of such a value, it uses an obvious placeholder instead.

#### 1.7.3 Existing Content

Where a secret or private information described in Sections 1.7.1 or 1.7.2 is
found in existing content, it is removed on sight. This is the one exception to
Section 2.2: preserving the historical record does not extend to preserving a
credential or private information that should never have been committed.

### 1.8 Safety and Side Effects

A snippet whose subject is inherently destructive, such as one that deletes,
overwrites, or otherwise damages data, is not prohibited on that basis alone.
It does, however, act on a scope it was deliberately given, such as a path
passed to it or a directory it creates for itself, rather than reaching into a
home directory or a system path on its own initiative.

Where causing damage is the point of the experiment, that is made evident to a
reader through the context required by Section 2.4.1 rather than left for a
reader to discover by running it.

Do not add a side effect that the stated purpose does not require. A safer or
more defensive-looking implementation is not an improvement if it silently
widens the files, state, network resources, or external systems the example can
affect.

### 1.9 Pull Request Scope and History

A pull request presents the change it proposes, not the sequence of corrections
that produced it. It carries one coherent higher-level purpose.

#### 1.9.1 One Purpose to a Pull Request

- "Purpose" means the higher-level reason the pull request exists, not an
  individual finding, issue, file, function, or review comment. Several
  findings may belong to one purpose when they are part of the same
  cross-cutting investigation, maintenance task, defect class, migration,
  repository reorganization, or quality correction.
- Do not split a pull request mechanically by finding or file. Before splitting
  one approved work group, consider semantic coherence, shared files, merge
  conflicts, duplicated validation, branch and pull-request management cost,
  and whether the parts truly need independent review, rollback, or acceptance.
- Changes that serve different purposes are proposed separately, as a rule,
  even when they touch one file and even when one was noticed while the other
  was being made.
- An unrelated change noticed in passing is proposed separately. A finding
  discovered while carrying out the approved purpose is not "in passing"
  merely because it was unknown before the investigation; it may remain in the
  same pull request when it serves that purpose.
- Tidying, renaming, reformatting, modernization, or cleanup that the change
  does not require is a different purpose and does not ride along.
- Work that cannot stand without the change is not a second purpose. Directly
  required documentation and an existing or explicitly approved test that
  demonstrates the changed behavior belong to the change that requires them.
- Where separating parts would be artificial because neither part is correct or
  reviewable without the other, keep them together and state the shared
  purpose.

#### 1.9.2 Keeping a Branch to Its Change

- A branch that carries one coherent change carries it as one commit.
- Revise that commit by amending and force pushing with `--force-with-lease`
  rather than adding commits such as "fix review comment", "address feedback",
  or "resolve conflict".
- Split a branch into several commits only when it genuinely carries several
  independent changes. Coherence, not chronology, decides.

#### 1.9.3 Leaving No Trace of the Correction

- Read each revision against the base branch, not merely against the previous
  revision, so that abandoned wording, code, comments, files, and temporary
  work do not remain in the diff that is merged.
- A correction withdraws what it replaces rather than leaving both versions
  standing.
- Resolve conflicts with the base branch by rebasing so that a merge commit
  does not enter the branch.
- Force pushing is confined to the branch under review. When the branch is
  shared, make the rewrite explicit because it invalidates previously fetched
  copies.

### 1.10 Validation and Judging a Change

Validation matches what changed and proves the property the change is meant to
preserve or establish.

- A documentation-only or policy-only change is not held to unrelated runtime
  tests.
- A source change is checked with the language- or project-appropriate syntax,
  build, static, test, or runtime validation that directly exercises what was
  changed.
- Do not add a test framework, harness, mock infrastructure, dependency, or
  validation mechanism merely to make a small unrelated change look more
  formal.
- Passing an automated checker is evidence about the implementation; it is not
  permission to violate the policy, the local contract, or the stated purpose.
- Review the final diff against the base branch and confirm that every changed
  file and every changed line belongs to the approved purpose.
- Validate documentation consistency whenever code and documentation describe
  the same changed behavior.

Before accepting a change, ask whether it is the smallest coherent change that
serves its purpose, whether it alters behavior outside that purpose, whether it
adds an unnecessary dependency or side effect, whether it exposes private
information, and whether directly affected documentation remains correct.

### 1.11 Attribution and License

Content adapted from an external article, answer, or documentation example
credits its source and respects any third-party license it carried.

This repository is dual licensed under the GPL version 3 or the LGPL version
3, at the user's option. See [LICENSE](LICENSE.md), [COPYING](COPYING), and
[COPYING.LESSER](COPYING.LESSER). This document does not change those terms.

## 2. Sandbox-Specific Policy

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
matches current practice in its language. Section 1.7.3 states the one
exception, for security and privacy.

### 2.3 Repository Structure

#### 2.3.1 Top-Level Organization

A top-level directory is, as a rule, organized around a language, a platform,
or a technology. What top-level directories currently exist is stated in the
repository README, not in this document, so that adding or removing one does
not require a policy change.

#### 2.3.2 Local Structure

There is no requirement that every top-level directory share the same internal
layout. A directory may hold small, standalone files directly, group related
work into subdirectories by library or theme, or do both; the choice is
whatever fits what that directory holds. Section 2.5 states the deliberate
exception for comparable cross-language experiments.

#### 2.3.3 Generated Project Trees

Where a top-level directory holds a project tree produced by a framework,
build tool, or IDE generator, that tree's own layout, formatting, and generated
files are left as the tool produced them. This policy does not require
restructuring a generated tree to match another directory, though
repository-authored documentation added alongside it still follows Section
1.6. Section 2.6 covers build output within such a tree.

### 2.4 Source Code

#### 2.4.1 Purpose and Context

A reader should be able to tell what a snippet is trying out. Where that is not
obvious from the code itself, the necessary context, such as what problem it
explores or what it demonstrates, is recorded in the file or in documentation
near it.

A project made of many files carries this context on its entry point rather
than repeating it in every generated or supporting file. A generated file or
generated project tree, as described in Section 2.3.3, is not required to carry
a repository-authored header of its own.

#### 2.4.2 Execution Requirements

Where how a snippet is run, built, or invoked is not self-evident from its
name, its language, or its location, that information is recorded in the file
or in documentation near it, so that a reader does not have to guess it.

#### 2.4.3 Language Conventions

Source code follows the established convention of the language, platform, or
tool it is written for. This document does not require a uniform style across
languages, and it does not catalogue per-language formatters, comment syntax,
or style rules; where such detail is useful to a reader, it belongs in that
directory's own README under Section 1.6.2.

#### 2.4.4 Dependencies

A dependency serves the purpose of the snippet that needs it. Do not add one
merely to make an example resemble another repository or another language's
implementation.

A third-party library or dependency a snippet needs is not vendored into the
repository without a specific reason tied to that snippet's purpose; ordinary
use loads it the way that language or platform normally serves it, or records
how to obtain it.

This document does not set a package-manager or version-support policy common
to every language.

#### 2.4.5 Failure, Continuation, and Output

Examples in this repository may use different languages and execution models,
but code with more than one logical step keeps three decisions separate: what
result occurred, whether independent later work may continue, and whether any
message needs to be emitted.

A missing required dependency or input, or a condition for which continuing
would produce an invalid, inconsistent, destructive, or otherwise unsafe
result, stops the affected example or logical operation. Do not turn such a
condition into a warning merely to keep execution moving.

Independent work may continue when the example's own contract makes that
continuation meaningful and the remaining result stays coherent. A normal
no-op, guard, or intentionally inapplicable path may be silent and is not a
warning merely because no work was performed.

Do not add logging, status output, or exit-code machinery solely to make an
example resemble another repository. Existing example-specific interfaces and
language-native conventions remain authoritative.

### 2.5 Cross-Language Experiments

The repository may place comparable exercises across multiple language or
platform directories, so that the same problem can be read against a different
language's idioms. Where it does, the following applies:

- The exercises in a given set are placed under the same subdirectory name in
  every language directory that carries that set.
- The same exercise means the same thing, and produces a deterministic result,
  in every language that carries it.
- Each language implements it in that language's own idiom rather than as a
  transcription of another language's solution; matching results are what is
  held in common, not matching code.
- A language or platform whose nature does not fit a given exercise is not
  required to carry it.

Which sets currently exist, their exercises, and the concrete input and
expected output of each are stated in the repository README under Section
1.6.1 and are not repeated here.

### 2.6 Data and Generated Artifacts

A small sample of data may be committed where it was written specifically for
the snippet that reads it. An external dataset or other third-party material is
not copied into the repository without a specific reason, given the
redistribution rights, size, and origin such material carries; a snippet that
needs one instead records where to obtain it.

Build output, caches, temporary files, and other generated artifacts are not
committed, except where the generated artifact is itself the subject of the
experiment. This document does not enumerate what is excluded; the
repository's ignore configuration does that.

### 2.7 Release and Maintenance

This repository is not maintained as a packaged release. It does not carry a
repository-wide version number, and a change to it is not a reason to introduce
one.

Backward compatibility is not offered as a general guarantee, automated test
coverage is not required of every snippet, and staying compatible with a
dependency's current version is not an ongoing obligation.

Those limits do not authorize a change to alter existing executable behavior
outside its stated purpose, and they do not permit a documentation-only change
to alter what existing executable code actually does.
