# Personal Data Impact Trace

## Purpose

This example identifies datasets recorded as stored on a selected system and
traces their recorded upstream transfers to related systems and operators.
The result identifies investigation candidates. It does not establish which
records an attacker obtained, how many people were affected, or whether
upstream systems were compromised.

## Requirements

- Python 3.12 or later
- Python standard library only

## Input

`inventory.csv` records which datasets are stored on each system. Its columns
must be `system,operator,dataset,subjects,data_type` in that order. `subjects`
identifies a category of people, not a person count.

`transfers.csv` records transfers of a dataset between systems. Its columns
must be `dataset,src,dst` in that order. Every transfer endpoint must have a
corresponding `(system, dataset)` entry in `inventory.csv`. Each pair must be
unique, and every occurrence of a dataset must agree on `subjects` and
`data_type`.

The included CSV files describe fictional organizations and systems.

## Run

From this directory:

```sh
python3 analyze.py --system subship
```

To read the two CSV files from another directory, pass
`--data-dir PATH`. The default is the current working directory.

The program writes a JSON array to standard output. Each element describes a
dataset on the selected system with its `subjects`, `data_type`,
`related_systems`, `related_operators`, and `transfers`. A transfer contains
`src` and `dst` in the recorded transfer direction. Related upstream systems
are information sources to investigate, not additional confirmed compromises.

Missing inputs, malformed rows, inconsistent records, invalid transfer
endpoints, and unknown selected systems cause an error. The program writes
`ERROR: ...` to standard error and exits with status 2.

## Test

From this directory:

```sh
python3 -m unittest -v
```

The seven tests cover two-stage tracing, excluding unrelated datasets from a
selected system's result, termination on cyclic transfers, and four invalid
input conditions.

## Files

- `analyze.py`: CLI and upstream transfer analysis
- `test_analyze.py`: deterministic unit tests
- `inventory.csv`: fictional storage inventory
- `transfers.csv`: fictional dataset transfer records
