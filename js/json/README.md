# JSON

JSON as a data format rather than as a JavaScript feature: what is here is a
shell script driving [`jq`](https://jqlang.org/), the command-line JSON
processor. The directory sits under `js` because the subject is the format,
and the file is a shell script because that is what `jq` is used from.

`jq` is worth knowing for the same reason `sed` and `awk` are: it makes JSON a
thing a pipeline can work on. A query is a filter — a path expression, a
construction, or both — and the interesting part is the two output modes shown
here, since the reason to reach for `jq` is usually to get *out* of JSON.

## Files

- `jq_example.sh` — three one-liners, each piping a literal object into `jq -r`
  and asking for CSV:
  1. `[.key1, .key2] | @csv` — two scalars collected into an array, printed as
     one CSV row.
  2. `[.key1, .key2[]] | @csv` — `[]` flattens the array-valued field into the
     surrounding array, so the four elements become four columns of one row.
  3. `{key1, key2: .key2[]} | [.key1, .key2] | @csv` — the same array iterated
     instead of flattened. Constructing an object per element makes `jq` emit
     one result per element, so this prints four rows rather than one, each
     pairing `key1` with a single element.

The three together are the distinction that takes the longest to learn about
`jq`: whether an array is being *collected* into one output or *iterated* into
several. `-r` is what strips the quotes `@csv` would otherwise be wrapped in.

## Running

    ./jq_example.sh
    # or: bash jq_example.sh

`jq` must be installed and on `PATH` (`apt install jq`, `brew install jq`).
Verified against jq 1.7; the output is six lines — one, then one, then four.

## Notes

The script carries `#!/bin/bash` and lives here rather than under `sh`, because
the repository groups by the subject being tried rather than by the interpreter
that happens to run the example. For JSON handling inside JavaScript itself,
`JSON.parse` and `JSON.stringify` need no sample; the server directories such
as [`fastify`](../fastify/) show what production code does around them —
validating the parse result before trusting it, and controlling what is
serialised back out.
