# Particle Structure Measurement

## Purpose

Measure the motion of a fixed particle set and changes in its proximity graph
separately. Two prescribed four-particle transitions check the observation
functions. A one-step two-particle model then applies the same functions to
positions computed from reciprocal and nonreciprocal interactions.

## Requirements

- Python 3.13 (the reference run used Python 3.13.5 on Debian GNU/Linux 13,
  x86_64).
- NumPy 2.2.4.
- Python assertions enabled. Set `PYTHONOPTIMIZE=0` and omit `-O` and `-OO`.

## Run

From the repository root, create an isolated environment and run the program:

```sh
python3.13 -m venv .venv
. .venv/bin/activate
python -m pip install numpy==2.2.4
PYTHONOPTIMIZE=0 python -B python/particle_structure/particle_structure.py
```

The setup commands prepare the environment. The experiment itself needs no
network access, external data, input files, standard input, command-line
arguments, or intentional file writes. It uses deterministic `float64` arrays.
The program runs the checks in order and prints eight lines to standard output:

```text
translation: velocity=(1.0, 0.0), amplitude=0.0, changed_edges=0, edge_count_delta=0
rearrangement: velocity=(0.0, 0.0), amplitude=2.0, changed_edges=4, edge_count_delta=0
reciprocal: velocity=(0.0, 0.0), amplitude=0.0, changed_edges=0, edge_count_delta=0
  distance=0.98
nonreciprocal: velocity=(0.1, 0.0), amplitude=0.0, changed_edges=0, edge_count_delta=0
  distance=1.00
boundary checks: PASS
All checks passed.
```

With assertions enabled, a successful run exits with status 0. A failed check
or unhandled exception exits nonzero. Output from completed earlier checks may
already have been printed. A missing NumPy installation prevents execution;
there is no alternative implementation. Importing the module does not run the
experiments or print their results.

## Measurements

Each row of a position array represents the same particle ID in both states.
The observation functions use nonempty, finite floating-point arrays of shape
`(N, 2)`, equal particle masses, and finite positive observation intervals and
cutoff distances. The two arrays must have the same shape and particle order.
The functions assume these input conditions rather than validating every one.

An undirected edge `(i, j)` with `i < j` exists when the Euclidean distance
between particles `i` and `j` is strictly less than the cutoff. The centroid
velocity is the difference of the arithmetic mean positions divided by the
observation interval. The structural amplitude is the square root of the
number of edges in the symmetric difference of the two edge sets. The signed
edge-count difference is the number of edges after the update minus the number
before it. Both measurements use the same observation interval.

## Checks and Expected Results

The four-particle initial positions are `(-0.5, -1.5)`, `(0.5, -1.5)`,
`(-0.5, 1.5)`, and `(0.5, 1.5)`, in that order. The observation interval is
1.0, and the proximity cutoff is 2.0.

- Translation adds `(1.0, 0.0)` to every position. Both edge sets are
  `{(0, 1), (2, 3)}`. The centroid velocity is `(1.0, 0.0)`, amplitude is
  0, and the changed-edge count and signed edge-count difference are both 0.
- Rearrangement replaces the positions with `(-1.5, -0.5)`, `(1.5, -0.5)`,
  `(-1.5, 0.5)`, and `(1.5, 0.5)`. The edge set changes from
  `{(0, 1), (2, 3)}` to `{(0, 2), (1, 3)}`. The centroid velocity is
  `(0.0, 0.0)`, amplitude is 2, changed-edge count is 4, and signed
  edge-count difference is 0.

The two-particle model starts at `(0.0, 0.0)` and `(1.0, 0.0)` with zero
velocities and unit masses. It takes one step of length 0.1. The interaction
radius and observation cutoff are separate parameters, both set to 2.0 in
this experiment. The pair functions assume finite position and velocity
arrays of shape `(2, 2)`, finite coefficients, and finite positive time step
and interaction radius.

For the unit direction from A to B, `e`, the forces inside the interaction
radius are `-g_ab * e` and `g_ba * e`. Positive coefficients denote repulsion,
and negative coefficients denote attraction. The step computes forces from
the current positions, updates velocities, and then updates positions using
the new velocities. The input arrays remain unchanged.

| Case | Coefficients (g_ab, g_ba) | Next positions (x components) | Next velocities (x components) | Centroid velocity (x component) | Distance |
| --- | --- | --- | --- | --- | --- |
| Reciprocal | (-1, -1) | (0.01, 0.99) | (0.1, -0.1) | 0.0 | 0.98 |
| Nonreciprocal | (-1, 1) | (0.01, 1.01) | (0.1, 0.1) | 0.1 | 1.00 |

All y components are zero. Both conditions preserve the edge `{(0, 1)}`,
so amplitude, changed-edge count, and signed edge-count difference are zero.

The embedded checks compare floating-point results with
`numpy.testing.assert_allclose` using `rtol=0.0`, `atol=1e-12`,
`equal_nan=False`, and `strict=True`. Sets and integer counts are compared
exactly. The checks also compare the original position and velocity arrays
with their saved copies. A distance equal to 2.0 produces no proximity edge;
forces at distances 2.0 and 3.0 are zero. Coincident particles raise
`ValueError` because the unit direction is undefined. The centroid function
raises `ValueError` for unequal array shapes or a nonpositive interval.

## Limitations

The four-particle transitions are prescribed test inputs with two connected
components, not results of spontaneous cluster formation. The pair experiment
checks only one update, not persistent motion or stability. The symmetric and
antisymmetric parts of the interaction coefficients both differ between the
two conditions, so this comparison does not isolate the causal contribution
of nonreciprocity.

The graph records binary proximity, not continuous distance or shape changes.
An edge added and removed between observations is invisible to an endpoint
comparison. The amplitude also depends on the number of candidate edges; use
comparable particle-set sizes or separately report the fraction of changed
candidate edges when comparing different sizes. This program uses ordinary
Euclidean coordinates without periodic boundaries. It examines all particle
pairs, requiring quadratic time for the proximity graph construction.

## Files

- `particle_structure.py` contains the observation functions, one-step pair
  model, fixed data, and embedded checks and output.
