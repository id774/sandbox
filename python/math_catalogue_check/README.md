# Mathematics Catalogue Check

## Purpose

This Python example inspects the OpenAI mathematics manuscript collection at
commit `1581d4cbdd69a0faf34b2089614fe2a814316a6a`. It counts result
families and manuscripts in `CONTENTS.md`, checks them against the repository's
`README.md`, and reports separate counts for YAML formalization sources and
main-result declarations. It also compares source paths with manuscript links
and reads the formalization fraction reported in `history.md`.

The YAML counts are metadata counts, not a reconstruction of the number of
formally verified manuscripts. The script does not run Lean or Comparator.

## Requirements

- Python 3.12 or later
- PyYAML 6.0.3
- Git with partial clone and sparse checkout support
- Network access to obtain the publicly available upstream repository

## Run

Use a working directory outside this sandbox repository. Replace
`/absolute/path/to/sandbox` with the local checkout path of this repository.
The script looks for input files beside its own path, so copy it to the root
of the upstream checkout before running it.

```sh
SANDBOX_ROOT=/absolute/path/to/sandbox
git clone --filter=blob:none --sparse --no-checkout https://github.com/openai/math.git
cd math
git sparse-checkout set --no-cone /README.md /CONTENTS.md /history.md /lean/formalization.yaml
git checkout --detach 1581d4cbdd69a0faf34b2089614fe2a814316a6a
git rev-parse HEAD
python3.12 -m venv .venv
. .venv/bin/activate
python -m pip install 'PyYAML==6.0.3'
cp "$SANDBOX_ROOT/python/math_catalogue_check/math_catalogue_check.py" .
python math_catalogue_check.py
```

For the cited revision, the expected output is:

```text
result_families: 372
manuscripts: 719
formalization_sources: 173
main_result_declarations: 200
unmatched_source_paths: 1
  preprints/Taming-implies-compatibility-on-four-manifolds-September-23-2026/paper.pdf
reported_formalized_top_line_results: 300/719 (~42%)
yaml_scope: Partial progress.
yaml_review: unchecked
```

The unmatched YAML source path differs from the current manuscript link,
`preprints/Taming-implies-compatibility-on-four-manifolds-October-6-2026/paper.pdf`.
This is a path mismatch in the metadata, not a conclusion about proof validity.
The `300/719` ratio is a reported value from `history.md`, not a fraction
calculated from the 173 source entries or 200 main-result declarations.

## Failure behavior

The script fails with a nonzero exit status for missing or unreadable inputs,
invalid YAML, unexpected source paths, duplicate family numbers, duplicate
manuscript links, duplicate Lean declarations, invalid main-result fields,
missing counts, or mismatches between reported totals and extracted totals.
These errors are reported by the Python exception mechanism. On success the
script prints the report to standard output; it does not modify inputs.

## Files

- `math_catalogue_check.py`: Article-matching Python implementation (with the
  sandbox-required source header)
