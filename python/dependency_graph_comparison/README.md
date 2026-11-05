# Dependency Graph Comparison

## Purpose

This standalone Python experiment compares the count of possible labeled simple
undirected graphs with the actual edge counts of a complete graph and a path
graph over the same fixed number of vertices. It uses formulas to calculate
the number of graph candidates; it constructs only the complete and path graphs.

## Requirements

- Python 3.12 or later (the article's implementation was run with Python 3.13.5)
- Python standard library only (`itertools` and `math`)
- Python assertions enabled (do not run with `-O` or `PYTHONOPTIMIZE`)

## Run

From the repository root:

```sh
python3 -B python/dependency_graph_comparison/graph_comparison.py
```

Expected standard output:

```text
 n | graph_candidates | complete_edges | path_edges
 4 | 64 |   6 |   3
10 | 35184372088832 |  45 |   9
20 | 1569275433846670190958947355801916604025588861116008628224 | 190 |  19
```

The script uses fixed vertex counts `4`, `10`, and `20`. It uses no external
input, reads no files, makes no network requests, and performs no intentional
file writes. It prints four lines and exits with status 0 when all assertions
pass. An assertion failure raises `AssertionError` and produces a nonzero exit
status; output from earlier iterations may already have been printed.

## Checks

For each vertex count `n`, the script verifies:

- The complete graph has `n * (n - 1) // 2` edges.
- The path graph has `n - 1` edges.
- Each generated edge set has no duplicates, and all endpoints are distinct
  vertices within the range `0` through `n - 1`.
- Every path graph edge connects successive vertices.

The candidate count is `2 ** (n * (n - 1) // 2)` and is calculated without
enumerating candidate graphs. Only one complete and one path graph are
constructed per vertex count.

## Limits

The graph model is undirected and has neither self-loops nor parallel edges.
Real software dependencies may be directed, and edge counts alone do not
establish change-propagation paths, coupling through public interfaces,
change effort, or failure probability. This example does not measure those
properties or benchmark performance.

## Files

- `graph_comparison.py`: fixed complete/path graph construction, assertions,
  and candidate-count/edge-count output.
