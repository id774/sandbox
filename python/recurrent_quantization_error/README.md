# Recurrent-State Quantization Error

## Purpose

This deterministic Python experiment compares local quantization error with
accumulated state error and final output error in a two-dimensional linear
recurrence. It checks three effects: the direction of injected errors relative
to the output readout, error persistence under different retention factors,
and quantization every step versus every eight steps.

## Requirements

- Python 3.13
- NumPy 2.3.4

## Run

From the repository root, create an environment and run the program:

```sh
python3.13 -m venv .venv
. .venv/bin/activate
python -m pip install numpy==2.3.4
python -B python/recurrent_quantization_error/quantization_error.py
```

Use a normal Python invocation without `-O` so the built-in assertions run.
The program takes no command-line arguments, reads no files, and makes no
network requests. An assertion failure or unhandled exception exits nonzero;
a successful run exits 0.

## Checks and Expected Results

- The errors `(0.02, 0.0)` and `(0.0, 0.02)` have the same local MSE
  (`0.000200`), while their output squared errors are `0.000400` and
  `0.000004`.
- After 100 steps, retention factors `0.99` and `0.5` retain approximately
  `0.366032341` and `7.88860905e-31`, respectively, of a one-time error.
- At 128 steps, interval 1 makes 128 quantization operations, with local MSE
  `0.001179956`, final state MSE `4.192005688`, output error
  `-2.900493329`, and output squared error `8.412861553`.
- Interval 8 makes 16 operations, with local MSE `0.002029791`, final state
  MSE `0.001712367`, output error `-0.025493329`, and output squared error
  `0.000649910`.
- Each step asserts that the measured state error matches its linear
  recurrence with the newly introduced quantization error.

## Scope

The model uses fixed `float64` arrays, the component-wise `numpy.round`
operation, and a quantization step of `0.125`. It does not model a finite
bit-width encoding, clipping, an actual language model, inference latency,
or memory savings. The direction comparison injects errors directly; the
interval comparison applies the specified rounding operation.

## Files

- `quantization_error.py`: the deterministic experiment and assertions.
