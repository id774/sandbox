# Citation Verification Contract

## Purpose

This standalone Python experiment checks whether citations in a generated
answer refer to sources in the current input and whether each cited claim has
an independently supplied support review for its current content. It separates
citation-ID resolution from semantic support. The program does not determine
whether a source actually supports a claim.

## Requirements

- Python 3.13 or later (validated with Python 3.13.5)
- Python standard library only (`argparse`, `hashlib`, `json`, `re`, `unittest`)
- No network connection, external credentials, or package installation

## Inputs

Three UTF-8 JSON files are included to reproduce the article's accepted case:

- `answer.json`: claims with an `id`, `text`, and `citation_id`
- `sources.json`: sources with an `id` and `content`
- `reviews.json`: external reviews with a `claim_id`, `fingerprint`, and
  `verdict` of `supported` or `unsupported`

Each claim cites exactly one source. A review fingerprint is SHA-256 over a
canonical JSON representation of the claim ID and text, citation ID, and source
content. The sample fingerprint matches the included sample inputs.

## Run

From the repository root:

```sh
python3 -B python/citation_contract/citation_contract.py python/citation_contract/answer.json python/citation_contract/sources.json python/citation_contract/reviews.json
```

The included sample produces `ACCEPT` and exits with status `0`. A decision
of `REVIEW` or `REJECT` exits with status `1`. File reading errors (including
invalid UTF-8) and JSON parsing errors exit with status `2` via `argparse`.

The decision rules are:

- `ACCEPT`: every citation ID resolves and every claim has a matching
  `supported` review for the current claim/source content
- `REVIEW`: a required review is absent or its fingerprint does not match
  the current claim/source content, unless rejection takes precedence
- `REJECT`: an input contract violation, missing citation source, duplicate
  ID, or matching `unsupported` review; rejection takes precedence over review

## Test

From the repository root:

```sh
python3 -B -m unittest discover -s python/citation_contract -p 'test_*.py' -v
```

The nine `unittest` methods cover supported answers, missing reviews,
missing and empty citation IDs, unsupported reviews, partially reviewed
answers, rejection precedence, stale claim/source fingerprints, and invalid
or duplicate data (including unpaired Unicode surrogates). All nine tests
must pass.

## Scope and Limits

`reviews.json` is assumed to be supplied by a trusted, independent review
process. A fingerprint checks the identity of reviewed content; it does not
authenticate reviewers, prove review independence, validate source truth, or
establish an answer's overall logical correctness. This experiment does not
retrieve sources, evaluate semantic support automatically, or handle multiple
citations per claim. It reads only the three paths supplied as arguments and
writes the JSON decision to standard output; it does not modify input files
or contact external services.
