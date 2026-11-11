# Directed Graph Change Measurement

## Purpose

Measure the structural amplitude, signed edge-count change, and exact added
and removed edges between successive states of a fixed directed graph. The
example uses four components (A, B, C, D), six possible directed edges, and
four updates. It demonstrates why equal amplitudes do not imply equal update
directions or identify the same changed edges.

## Requirements

- Python 3.8 or later; the reported sample run used Python 3.13.5.
- Python standard library only (`math` and `unittest`).
- No installation, network access, input files, or command-line arguments.

## Run

From `python/directed_graph_change_measurement`:

```sh
python3 -B structure.py
python3 -B -m unittest -v
```

The sample program prints exactly these six lines and exits with status 0:

```text
t  vector               edges  amplitude  delta
0  (1, 1, 1, 0, 0, 0)       3          -      -
1  (1, 1, 1, 1, 1, 0)       5      1.414     +2
2  (1, 1, 1, 1, 0, 0)       4      1.000     -1
3  (1, 1, 1, 0, 0, 0)       3      1.000     -1
4  (1, 1, 1, 0, 0, 1)       4      1.000     +1
```

The unit test command runs 10 tests and returns status 0 when all pass.
The `unittest` runner prints test details and `OK` on standard error;
its elapsed-time display depends on the runtime.

## Graph and Measurements

The fixed ordered candidate edges are `(A, B)`, `(B, C)`, `(C, D)`,
`(A, D)`, `(B, D)`, and `(A, C)`. Each state is a `frozenset` of these
edges. Encoding preserves that order as six binary coordinates.

The state sequence contains the first three edges initially, adds the
fourth and fifth edges, removes the fifth, removes the fourth, and then
adds the sixth. For each adjacent pair, `measure` returns the destination
vector, Euclidean amplitude via `math.dist`, signed edge-count difference,
edge count, and the exact `added` and `removed` sets.

For `a` added and `r` removed edges, amplitude squared equals `a + r`
and signed edge-count change equals `a - r`. Thus a single addition and
a single removal both have amplitude 1, but opposite signed changes.
Two removals can have identical amplitude and signed difference while
removing different edges. The first and fourth states are equal despite
intermediate additions and removals.

## Validation

`test_structure.py` contains 10 `unittest` cases that verify the initial
encoding, order independence, rejection of unknown or reversed edges,
unchanged state, the four fixed updates, opposite directions at equal
amplitude, distinct removed edges at equal metrics, the amplitude-squared
identity, and return to the initial state.

`encode` raises `ValueError` for a candidate edge not present in the fixed
ordered set. The demonstration has no file writes, network operations,
random input, or external side effects. A failed unit test produces a
nonzero exit status; importing `structure.py` does not print the sample output.

## Limitations

The graph is directed, unweighted, and restricted to six candidate edges;
other edges, internal component changes, call frequencies, and latencies
are outside its representation. Amplitude and edge-count differences do
not measure maintenance effort, correctness, safety, or operational impact.
The sample data does not establish that bypassing the input-validation
component is safe. It does not read an actual dependency graph.

## Files

- `structure.py`: fixed states, graph encoding, measurements, and sample output.
- `test_structure.py`: 10 standard-library unit tests for the measurements.
