# Sandbox Policy

This document states the repository-wide implementation and maintenance rules
that apply when code, documentation, or data is added to or changed in this
repository.

Sections 0 and 1 are intentionally repository-independent. Together they form
a reference set of reusable policy principles, not a template to copy
verbatim. When defining policy for a new software repository, first determine
that repository's own purpose, requirements, architecture, constraints,
operating model, compatibility commitments, release model, and other
repository-specific needs. Then adopt, adapt, or omit the principles in
Sections 0 and 1 according to whether they apply. Section 2 specializes those
principles for this repository and is not part of that reference set.

This document stands on its own. It is the whole implementation policy of this
repository, and no rule here is completed by a document kept somewhere else. A
subject it does not cover is a gap in this document, to be filled here rather
than looked up elsewhere.

## 0. Governing Principle

**Simplicity is robustness.**

This is the governing principle for every rule below. It does not authorize
dropping required behavior, compatibility, security, safety, documentation, or
validation. It requires satisfying those requirements with no more complexity
than the actual problem justifies.

Complexity is itself a source of failure, compatibility risk, operational risk,
security risk, and maintenance cost. Do not add a branch, state variable,
helper, abstraction, dependency, network boundary, retry, fallback, validation,
configuration state, or framework unless the specification requires it or it
addresses a realistic failure mode with meaningful consequence.

Do not re-check a condition already guaranteed by a preceding successful
operation or an established invariant. Do not create a layer merely to resemble
a possible future architecture.

When two designs satisfy the same requirements, choose the one with less
control flow, less state, fewer dependencies, fewer side effects, fewer moving
parts, and fewer operational assumptions. Simplicity is judged by the number of
necessary concepts and behaviors, not by line count alone.

## 1. General Policy

### 1.1 Purpose and Scope

This section defines repository-wide implementation and maintenance rules that
remain meaningful independently of a particular product, domain, language,
platform, release model, or repository layout.

The rules apply when the stated scope of a change reaches the behavior or
structure they govern. They do not, by themselves, authorize revisiting
unrelated existing content.

A repository's concrete purpose, architecture, compatibility commitments,
release model, domain contracts, and other repository-specific requirements
belong in its repository-specific policy or another authoritative document.

### 1.2 Decision Priorities and Maintainer Judgment

Where more than one implementation or maintenance choice satisfies the stated
purpose, judge the alternatives in this order:

1. Preserve the stated scope and the intended, valid observable behavior that
   the change was not asked to alter.
2. Preserve safety and privacy: do not destroy, overwrite, expose, or publish
   anything the change was not asked to touch.
3. Prefer the simpler implementation with fewer dependencies, moving parts,
   side effects, and operational assumptions.

Where this policy and the applicable local documentation leave more than one
valid choice, an explicit maintainer decision settles that choice. A general
best practice, a convention from another repository, or a newer technique does
not override that decision.

### 1.3 Wording Strength

Use `must`, `always`, and `never` only for invariants that admit no reasonable
exception. Express preferences and situational decisions with `prefer`,
`should`, or other qualified wording.

Do not apply a rule literally where doing so would defeat the repository's
stated purpose, intended behavior, compatibility, safety, or approved change
scope.

Where the applicable specifications and policy leave a legitimate choice
open, an explicit maintainer decision governs that choice. General
conventions do not override it.

This is not a formal MUST/SHOULD/MAY taxonomy.

### 1.4 Change Discipline and Observable Behavior

A change touches only what its stated purpose requires. Unrelated refactoring,
reformatting, modernization, cleanup, renaming, feature work, or documentation
rewriting does not ride along with it, even when it would be a plausible change
on its own.

Documentation work, policy work, review, diagnostics, cleanup, or another
task whose stated scope does not include an implementation change must not
expand into one merely because an improvement opportunity is discovered.

Before changing established behavior, weigh the probability and impact of the
failure being prevented against the added complexity, new failure modes,
compatibility risk, operational cost, maintenance cost, and rollback cost.

A safety-motivated change is not automatically justified by Safety having
priority over Efficiency. Added complexity can itself create new failure
modes, compatibility risk, operational risk, and maintenance cost. Evaluate
the proposed change as a whole.

Behavior that has operated reliably over time is evidence and has value of
its own. Do not refactor established infrastructure merely because another
design appears cleaner, more modern, or more defensive.

An implementation change is made only when that change has been explicitly
chosen as part of the work being performed. Before deployment, validate it in
the supported and representative environments affected by the change. A
successful check in one convenient environment is not sufficient evidence for
a change whose compatibility risk extends to other supported environments.

When the task does not require a behavior change, preserve the intended and
valid existing observable behavior of the affected content. That includes, as
applicable, control flow, processing order, continuation after failure, side
effects, output, exit status, options, defaults, configuration semantics, file
layout, and generated results.

A clear defect is not protected merely because the current code exhibits it.
Correct it when correcting that defect is part of the stated purpose. Finding a
defect while doing unrelated work does not by itself add its correction to the
current scope.

The implementation is the primary evidence of what currently happens. It is
not, by itself, proof that the current behavior is the intended specification.

When implementation and documentation disagree, compare the implementation,
documented interface, component header, history, existing design, and
maintenance intent. If the implementation contains a regression, do not adopt
that regression as the specification merely because it is present in the
current code.

When an authorized implementation change alters behavior or an interface that
the repository documents, update the directly affected documentation in the
same change. This requirement does not authorize unrelated documentation
cleanup. Likewise, changing documentation does not silently change executable
behavior. If the document and implementation disagree, determine which is
wrong from the repository's stated purpose and local source of truth, and
change only the side the task requires.

### 1.5 Repository-Wide and Local Rules

This policy is the repository-wide floor. A rule that applies only to one
component, language, platform, technology, generated project, directory, or
other narrower scope is kept with that scope, normally in the responsible
README, local policy, or source when the constraint is inseparable from the
source itself.

A local rule may narrow what is permitted in its scope. It does not relax a
repository-wide safety, privacy, attribution, licensing, or change-discipline
rule stated here.

Do not impose one implementation style mechanically across different
languages, platforms, components, or tools. Apply the native convention and
the local contract unless doing so conflicts with a repository-wide rule.

### 1.6 Dependencies and Optional Capabilities

Minimize dependencies when doing so does not compromise the stated purpose or
make the implementation unreasonable. Dependency reduction is a design
preference, not an end in itself.

A dependency or capability is required only on an execution path that actually
needs it. Do not make an optional capability a repository-wide prerequisite
merely because one component, feature, or execution path can use it.

Detect an optional capability where its result affects behavior. Its absence
must select behavior already allowed by the applicable contract: use an
established alternative, skip an optional operation, or refuse the affected
operation. Do not invent a fallback merely to keep processing.

Do not add a check whose only purpose is to reconfirm a state already
guaranteed by an established invariant or by a preceding operation that
completed successfully. Add a separate check only when the condition can vary
independently and its result changes safe behavior, reporting, fallback, or
another observable choice.

### 1.7 Environment Differences

When the question is whether a capability exists or is usable, detect that
capability rather than using an operating-system, distribution, runtime,
terminal, or other environment name as a proxy for it.

Use an environment identity only when the identity itself determines the fact
that varies, such as a platform-specific path, file format, API, or other
genuinely environment-specific contract.

Keep one logical capability decision in one place. Do not answer the same
environment question independently in several locations when one established
decision can be reused.

### 1.8 Failure, Continuation, and Reporting

Treat the result of an operation, whether later work continues, and whether
anything is reported as separate decisions.

A missing required dependency or input, invalid state, or another condition
that makes correct completion impossible or would make continuation invalid,
inconsistent, destructive, or otherwise unsafe stops the affected logical
operation. Do not turn such a condition into a warning merely to keep
processing.

Independent later work may continue only when the applicable contract permits
it and the remaining result can still be coherent and valid.

A normal no-op, guard, intentionally inapplicable path, or supported absence is
not a warning merely because no work was performed and may be silent.

Do not add output merely to narrate ordinary control-flow choices. Report a
condition when the user or operator can use the information or when an
established interface requires it.

### 1.9 Security and Privacy

#### 1.9.1 Secrets

No API key, password, access token, private key, or session credential, live,
expired, or of unknown status, is committed to this repository.

#### 1.9.2 Private Information

No private infrastructure information, such as a real internal host name or
network address, and no personal information that is not intended for public
disclosure, is committed to this repository. Where source, documentation,
configuration, fixtures, or examples need such a value, they use an obvious
placeholder instead.

#### 1.9.3 Existing Content

Where a secret or private information described in Sections 1.9.1 or 1.9.2 is
found in existing content, it is removed on sight. Preservation of historical
or existing content never extends to preserving a credential or private
information that should never have been committed.

### 1.10 Safety and Side Effects

Code, tooling, or automation whose purpose is inherently destructive is not
prohibited on that basis alone. It must, however, act only on the scope
deliberately supplied to it or established by its applicable contract rather
than broadening the target on its own.

Where destructive behavior is intentional, make that behavior and its affected
scope evident before execution through the applicable interface or
documentation.

Do not add a side effect that the stated purpose does not require. A safer or
more defensive-looking implementation is not an improvement if it silently
widens the files, state, network resources, or external systems the change can
affect.

### 1.11 Privilege

Use only the privilege required by the work being performed.

Do not run an entire program, example, installer, or operation with elevated
privilege merely because one step requires it when the elevated scope can be
confined to that step.

Do not add privilege acquisition, a broader execution identity, or wider
access as a defensive convenience. The scope and duration of elevated access
must follow from the stated purpose.

Where elevated privilege or an alternate execution identity is part of the
intended behavior, make that requirement and its affected scope explicit rather
than leaving it to be discovered during execution.

### 1.12 Naming, Comments, and Language

A new directory, file, identifier, or other named thing takes a name that
identifies it accurately and stably, in the way it is ordinarily referred to.
Name a thing by what it is, not by one interface, representation, format, or
container it happens to use.

An existing path is not renamed only to bring it into line with a convention
adopted later. A path may be linked to from outside the repository, and
uniformity alone does not justify breaking that path.

Comments and identifiers are written in English, except where non-English text
is required by the repository's domain, interface, localization, protocol,
test data, or text-processing behavior.

A comment preserves a reason, constraint, non-obvious intent, or decision that
a later change could otherwise undo. Do not use comments merely to restate code
whose operation is already evident.

Write English explanatory prose in clear, natural sentences. Do not replace a
sentence with a label and a colon, a status prefix such as `Implement:` or
`Incompatible:`, a symbol, or an unexplained abbreviation.

Apply this to English prose in comments, docstrings, documentation, version
histories, release notes, commit messages, and pull request descriptions.

This rule does not alter the established forms of headings, list labels,
tables, code, configuration syntax, machine-readable fields, literal
interface strings, or non-English content required by the repository's
purpose.

Wrap ordinary prose at approximately 80 columns where practical. Preserve
the logical structure of paragraphs, lists, and other document elements.
Do not break URLs, code, tables, identifiers, or other elements whose
structure requires a longer line.

Shared boilerplate must retain its common wording, line breaks, blank lines,
and formatting. Do not reformat it independently in individual repositories.
Its established common form takes precedence over the ordinary line-wrapping
guideline.

Do not rewrite historical entries or unrelated text merely to align their
style.

### 1.13 Documentation

#### 1.13.1 Repository README

The root README is the repository's entry point. It describes the repository's
purpose, how to use or navigate it at the appropriate level, its high-level
structure, and the authoritative documents a contributor or operator needs to
find. It does not duplicate detailed specifications whose source of truth is
elsewhere.

#### 1.13.2 Local Documentation

Behavior, interfaces, constraints, or operating information that applies only
to one component, directory, tool, language, or other local scope is documented
at the narrowest stable location where a reader working in that scope will find
it. A local README is appropriate when that local scope is a directory or
component.

#### 1.13.3 Local Constraints

A local constraint may narrow what is permitted within its scope, but it does
not relax a repository-wide rule. Keep a local constraint with the scope that
owns it rather than duplicating it throughout unrelated documentation.

#### 1.13.4 Single Source of Truth

A concrete specification has exactly one authoritative home appropriate to the
responsibility that owns it. Other documents may link to or summarize that
specification for navigation, but they do not create a competing normative
copy.

This policy states repository-wide implementation and maintenance rules. It
does not duplicate product, domain, component, protocol, interface, or
repository-specific specifications whose source of truth belongs elsewhere.

### 1.14 Pull Request Scope and History

A pull request carries one coherent higher-level purpose, which may require
coordinated changes across several files or responsibilities.

Do not split one approved purpose mechanically by individual finding, file,
or review comment, and do not include unrelated cleanup, formatting, or
feature work.

Represent one coherent change as one commit and amend review corrections
instead of accumulating follow-up commits.

Rewriting the history of a branch under review requires an explicit
instruction from the maintainer. When such a rewrite is authorized, use
`--force-with-lease` and limit the operation to the branch under review.

Check the final branch against its base to remove abandoned intermediate
wording and work. Merge only with explicit maintainer approval.

Unless explicitly instructed otherwise by the maintainer, an automated agent
must commit authorized changes to a work branch and submit them through a
pull request targeting the approved base branch.

An automated agent must not commit or push directly to `master` without
explicit instructions from the maintainer authorizing that operation.

Creating or updating a pull request does not authorize the agent to merge it
or enable auto-merge. Either action requires an explicit instruction from
the maintainer.

Authorization for one operation does not imply authorization for another.
These rules do not change a human maintainer's authority.

#### 1.14.1 One Purpose to a Pull Request

- "Purpose" means the higher-level reason the pull request exists, not an
  individual finding, issue, file, function, or review comment. Several
  findings may belong to one purpose when they are part of the same
  cross-cutting investigation, maintenance task, defect class, migration,
  repository reorganization, or quality correction.
- Before splitting one approved work group, consider semantic coherence,
  shared files, merge conflicts, duplicated validation, branch and pull-request
  management cost, and whether the parts truly need independent review,
  rollback, or acceptance.
- Changes that serve different purposes are proposed separately, as a rule,
  even when they touch one file and even when one was noticed while the other
  was being made.
- An unrelated change noticed in passing is proposed separately. A finding
  discovered while carrying out the approved purpose is not "in passing"
  merely because it was unknown before the investigation. It may remain in the
  same pull request when it serves that purpose.
- Tidying, renaming, reformatting, modernization, or cleanup that the change
  does not require is a different purpose and does not ride along.
- Work that cannot stand without the change is not a second purpose. Directly
  required documentation and an existing or explicitly approved test that
  demonstrates the changed behavior belong to the change that requires them.
- Where separating parts would be artificial because neither part is correct or
  reviewable without the other, keep them together and state the shared
  purpose.

#### 1.14.2 Keeping a Branch to Its Change

- Split a branch into several commits only when it genuinely carries several
  independent changes. Coherence, not chronology, decides.

#### 1.14.3 Leaving No Trace of the Correction

- Read each revision against the base branch, not merely against the previous
  revision, so that abandoned wording, code, comments, files, and temporary
  work do not remain in the diff that is merged.
- A correction withdraws what it replaces rather than leaving both versions
  standing.
- Resolve conflicts with the base branch by rebasing so that a merge commit
  does not enter the branch.
- When the branch under review is shared, make the rewrite explicit because it
  invalidates previously fetched copies.

### 1.15 Validation and Judging a Change

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
- Passing an automated checker is evidence about the implementation. It is not
  permission to violate the policy, the local contract, or the stated purpose.
- Review the final diff against the base branch and confirm that every changed
  file and every changed line belongs to the approved purpose.
- Validate documentation consistency whenever code and documentation describe
  the same changed behavior.

Before accepting a change, ask whether it is the smallest coherent change that
serves its purpose, whether it alters behavior outside that purpose, whether it
adds an unnecessary dependency or side effect, whether it exposes private
information, and whether directly affected documentation remains correct.

### 1.16 Attribution and Licensing

Content adapted from an external article, answer, documentation example, source
file, dataset, or other third-party material credits its source and respects
the license or redistribution terms that apply to it.

Repository-owned content follows the repository's declared license. Third-party
code, data, documentation, and dependencies retain or satisfy their applicable
licensing and attribution requirements.

The concrete repository license choice and the paths of its license texts are
repository-specific. They belong in the repository-specific policy or the
authoritative license documents rather than in this reusable General Policy.

## 2. Sandbox-Specific Policy

### 2.1 Experimental by Design

This is a sandbox: a personal workspace for prototypes, language studies, and
one-off experiments, not a maintained, production toolset. The rules below are
a floor for what is added to it, not a gate that existing content is expected
to pass. They apply to a repository change made from now on. They are not a
reason, by themselves, to go back and revise something already committed.

The repository exists for trying an idea out. Production readiness,
reusability, ongoing maintenance, and staying current with a dependency's
latest release are not required of what is added here. Code that is
incomplete, that only partly works, or that uses an older idiom or API is not,
by itself, a policy violation.

### 2.2 Preserve Historical Experiments

Existing content is a record of what was tried and when. A snippet is not
rewritten, upgraded, or removed only because it is old, no longer runs against
a current interpreter or library, uses a deprecated interface, or no longer
matches current practice in its language. Section 1.9.3 states the one
exception, for security and privacy.

### 2.3 Repository Structure

This policy does not describe what the repository currently contains. That is
the responsibility of the repository README and the README of each top-level
directory. Adding, removing, or changing a language, a platform, or an exercise
does not by itself require this document to change.

#### 2.3.1 Top-Level Organization

A top-level directory is, as a rule, organized around a language, a platform,
or a technology. What top-level directories currently exist is stated in the
repository README, not in this document, so that adding or removing one does
not require a policy change.

#### 2.3.2 Local Structure

There is no requirement that every top-level directory share the same internal
layout. A directory may hold small, standalone files directly, group related
work into subdirectories by library or theme, or do both. The choice is
whatever fits what that directory holds. Section 2.5 states the deliberate
exception for comparable cross-language experiments.

#### 2.3.3 Generated Project Trees

Where a top-level directory holds a project tree produced by a framework,
build tool, or IDE generator, that tree's own layout, formatting, and generated
files are left as the tool produced them. This policy does not require
restructuring a generated tree to match another directory, though
repository-authored documentation added alongside it still follows Section
1.13. Section 2.6 covers build output within such a tree.

#### 2.3.4 Repository README

The root README describes the repository's purpose, its current top-level
directories and what each one is for, its current cross-language experiment
sets and the concrete exercises they contain, and how to navigate it. It is the
current inventory of what the repository holds.

#### 2.3.5 Directory README

Each top-level directory organized around a language, platform, or technology
has a README that describes what that directory represents, what the directory
itself contains, and any constraint local to that directory.

#### 2.3.6 Local Constraints

A constraint that applies only within one directory, such as a language subset
a directory's contents are held to, is stated in that directory's own README,
where a reader working in that directory will see it. Such a local constraint
may narrow what is written in that directory beyond what this document asks.
It may not relax a repository-wide rule this document states.

#### 2.3.7 Concrete Specifications

A concrete specification, such as what a given exercise computes, what input
it uses, or what output it produces, has exactly one authoritative statement,
in the README responsible for it under Sections 2.3.4 and 2.3.5. This document
does not restate or duplicate that detail. It states only the rule that such
detail belongs to a README and not to this document.

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
or style rules. Where such detail is useful to a reader, it belongs in that
directory's own README under Section 2.3.5.

Comments and identifiers are written in English, except where non-English text
is itself the subject or data of the experiment, such as an encoding, locale,
natural-language, or text-processing example.

#### 2.4.4 Dependencies

Section 1.6 governs whether a dependency is justified and how an optional
capability is handled.

A third-party library or dependency a snippet needs is not vendored into the
repository without a specific reason tied to that snippet's purpose. Ordinary
use obtains it through the normal mechanism of that language or platform, or
records how to obtain it.

This document does not set a package-manager or version-support policy common
to every language.

#### 2.4.5 Failure, Continuation, and Output

Section 1.8 governs the relationship between an operation result,
continuation, and reporting.

Examples in this repository may use different languages and execution models.
Do not add logging, status output, or exit-code machinery solely to make an
example resemble another repository. Existing example-specific interfaces and
language-native conventions remain authoritative.

#### 2.4.6 Destructive and Privileged Experiments

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

Where privilege itself is the subject of an experiment, make that requirement
and its affected scope explicit rather than leaving it for a reader to discover
by running the example.

#### 2.4.7 Header Documentation

Repository-authored source files added by a change, and existing
repository-authored source files explicitly included in a header-documentation
maintenance change, carry a header appropriate to the language, platform, or
tool. This requirement does not by itself make unrelated historical source
files part of a change.

The header identifies the file and its purpose without requiring the reader to
infer them from the implementation. It includes the following repository
metadata:

- `Author: id774 (More info: https://id774.net)`
- `Source Code: https://github.com/id774/sandbox`
- `License: The GPL version 3, or LGPL version 3 (Dual License).`
- `Contact: idnanashi@gmail.com`

A standalone program, directly runnable test or evaluation, or project entry
point also records how it is run, built, or tested and the requirements needed
to do so. Requirements state practical minimum versions for the runtime,
compiler, tool, and directly required library where a meaningful minimum
applies. A practical minimum is a version reasonably expected to support the
current sample from its source, configuration, manifest, and documented APIs.
It does not need to be the earliest version that could theoretically run it.

In a multi-file project, the entry point carries the full project-level usage
and requirements. Supporting source files keep a concise header with the
repository metadata and enough description to identify their role, and may
refer to the entry point or local README instead of duplicating project-wide
setup and dependency details. Generated files and third-party source are not
given repository-authored headers. Sections 1.16 and 2.3.3 continue to govern
attribution, licensing, and generated project trees.

Header syntax follows the language or platform convention under Section 2.4.3.
Do not add a uniform comment form across languages merely to make headers look
alike. Do not duplicate detailed behavioral specifications, file inventories,
or other material whose authoritative home is a README under Section 2.3.7.

These rules apply to individual source files that carry their own version
history. Repository release versions are governed separately.

- Source file versions use a two-level `major.minor` scheme.
- When incrementing `minor` would reach `10`, roll over instead: increment
  `major` by 1 and reset `minor` to `0` (for example `v0.9` -> `v1.0`,
  `v1.9` -> `v2.0`, `v2.9` -> `v3.0`).
- Do not continue `minor` past `9` as in standard semantic versioning
  (do not use `v1.10`, `v1.11`, ...).
- Raising `major` for a reason other than the rollover is a decision the
  maintainer makes, not one this document derives from the change.
- Removing or renaming an option, changing what an existing argument means,
  changing a default so that an unchanged invocation does something else, and
  changing how a path or a configuration value is resolved are all incompatible
  changes. Say so in the `Version History` entry, so that the number the change
  is released under can be chosen knowing that.

### 2.5 Cross-Language Experiments

The repository may place comparable exercises across multiple language or
platform directories, so that the same problem can be read against a different
language's idioms. Where it does, the following applies:

- The exercises in a given set are placed under the same subdirectory name in
  every language directory that carries that set.
- The same exercise means the same thing, and produces a deterministic result,
  in every language that carries it.
- Each language implements it in that language's own idiom rather than as a
  transcription of another language's solution. Matching results are what is
  held in common, not matching code.
- A language or platform whose nature does not fit a given exercise is not
  required to carry it.

Which sets currently exist, their exercises, and the concrete input and
expected output of each are stated in the repository README under Section
2.3.4 and are not repeated here.

### 2.6 Data and Generated Artifacts

A small sample of data may be committed where it was written specifically for
the snippet that reads it. An external dataset or other third-party material is
not copied into the repository without a specific reason, given the
redistribution rights, size, and origin such material carries. A snippet that
needs one instead records where to obtain it.

Build output, caches, temporary files, and other generated artifacts are not
committed, except where the generated artifact is itself the subject of the
experiment. This document does not enumerate what is excluded. The
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

The experimental nature of this repository does not turn an unrelated behavior
change into part of a task. At the same time, this repository does not promise
general backward compatibility for every historical experiment. The
maintenance boundary in this section defines that limit.

### 2.8 License

Follow the applicable terms in [LICENSE](LICENSE.md), [COPYING](COPYING), and
[COPYING.LESSER](COPYING.LESSER). This policy does not redefine them.

### 2.9 Links to Self-Published Articles

Do not add links to the repository author's own blog posts, Qiita or Zenn
articles, or other self-published articles as background information, further
reading, source references, or promotion for repository-owned experiments. This
applies to source code, comments, headers, README files, and other repository
documentation.

Each experiment must describe its purpose, implementation, execution
requirements, expected results, and limitations within the repository, without
relying on a separately published article for that information.

This restriction does not affect required third-party attribution and licensing
under Section 1.16, repository metadata required by Section 2.4.7, or URLs used
as actual inputs, test data, or functional examples. External references
serving a necessary technical or legal purpose remain permitted.
