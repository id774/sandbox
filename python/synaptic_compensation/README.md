# Synaptic Compensation

## Purpose

This deterministic Python experiment compares unconstrained proportional
weight updates with updates clipped to an allowed weight interval. It checks
whether the output error converges, oscillates, or diverges as the update
coefficient changes, and shows that a convergent bounded update can leave
an unavoidable output error.

## Requirements

- Python 3.6 or later, which supports the f-strings used by the example.
- Python standard library only (`math`).
- No external packages, input data, network access, or elevated privileges.

## Verified Environment

Tested with Python 3.13.5.

## Run

From the repository root:

```sh
python3 -B python/synaptic_compensation/compensation.py
```

Use a normal invocation without `-O` so that the built-in assertions execute.
The program takes no command-line arguments, reads no files or standard input,
uses fixed parameters, and performs no intentional file writes or network
operations. A successful run exits with status 0 and prints exactly:

```text
eta   q       e0        e1        e4
  1   0.50   0.50000   0.25000   0.03125
  2   0.00   0.50000   0.00000   0.00000
  3  -0.50   0.50000  -0.25000   0.03125
  4  -1.00   0.50000  -0.50000   0.50000
  5  -1.50   0.50000  -0.75000   2.53125

constrained: eta=1, limits=[0, 1.5]
t=0 w=1.00000 y=0.50000 e=0.50000
t=1 w=1.50000 y=0.75000 e=0.25000
t=2 w=1.50000 y=0.75000 e=0.25000
t=3 w=1.50000 y=0.75000 e=0.25000
t=4 w=1.50000 y=0.75000 e=0.25000
all checks passed
```

An assertion failure or unhandled exception exits nonzero. The example runs
five unconstrained cases and one bounded case, then prints `all checks passed`
only after every assertion has succeeded.

## Model and Checks

For constant activity `x > 0`, weight `w_t`, target `y*`, and coefficient
`eta > 0`, the model uses output `y_t = x * w_t` and error
`e_t = y* - y_t`. The update rule is
`w_(t+1) = w_t + eta * e_t`. Unconstrained error evolves as
`e_t = (1 - eta * x)**t * e_0`. For a nonzero initial error, its
asymptotic convergence condition is `0 < eta * x < 2`.

The fixed sample uses `x = 0.5`, `y* = 1.0`, `w_0 = 1.0`, and four updates.
It evaluates `eta` in `(1, 2, 3, 4, 5)` and prints the error at steps 0, 1,
and 4. `verify_unconstrained` uses `math.isclose` with relative and absolute
tolerances of `1e-12` to compare every simulated error with the analytic
recurrence and every output with `target - expected_error`.

The bounded case uses `eta = 1.0` and `limits = (0.0, 1.5)`. Each proposed
new weight is clipped into the interval. Since the required weight is `2.0`,
the upper bound restricts output to `0.75` and leaves error `0.25`. The
sample asserts the final weight and final error at step 4.

## Validation

Run the command above without optimization. The check passes when all six
fixed scenarios complete, the analytic error and output assertions pass with
relative and absolute tolerances of `1e-12`, the bounded final weight is
`1.5` and the final error is `0.25` under the same tolerances, the program
prints the complete expected output, and the process exits with status 0.
The output should be compared byte for byte with the block above.

## Limitations

Activity and target output are fixed positive scalar model values. A single
weight stands for a combined effect rather than measured synaptic strength.
The bounded example clips one scalar weight, with fixed input limits and four
updates. It does not infer biological learning dynamics from physiological
data. The convergence proof concerns the defined discrete-time model; a
four-step demonstration alone does not prove convergence at infinite time.

## Files

- `compensation.py`: proportional updates, fixed numerical comparisons,
  recurrence assertions, and the bounded sample.
