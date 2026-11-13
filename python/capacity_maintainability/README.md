# Capacity Maintainability

## Purpose

This standalone Python experiment computes the initial capacity margin needed
for a specified number of state updates and the maximum maintainable horizon.
It distinguishes satisfying the current capacity constraint from maintaining it
under bounded demand increases and bounded capacity additions.

## Requirements

- Python 3.12 or later (the original sample was run with CPython 3.13.5).
- Python standard library only.
- No installation, external input files, network access, or elevated privileges.

## Run

From `python/capacity_maintainability`:

```sh
python3 -B capacity.py
python3 -B -m unittest -v test_capacity
```

The sample program prints the following output and exits with status 0.

```text
step capacity demand margin allowed
0    120      100    20     True
1    140      130    10     True
2    160      160    0      True
3    180      190    -10    False
4    200      220    -20    False
5    220      250    -30    False

Required margin for 5 periods: 50
Maximum maintainable periods: 2
```

The test command runs seven test methods and exits with status 0 when all
pass. The runner reports test results and `OK` on standard error. Its elapsed
time varies. A failed test or an unhandled error produces a nonzero exit
status. The sample takes no command-line options, reads no input files or
standard input, and does not write files. Importing the module produces no
sample output.

## Model and Checks

Capacity `c` and demand `r` are nonnegative integers in requests per second.
One period is one state update. The capacity addition `u` is chosen before
observing the demand increase `w`, with `0 <= u <= U` and `0 <= w <= W`.
Additions take effect by the next state and can be repeated each period.
There is no upper bound on total capacity. The update is `c += u`, `r += w`,
so the margin `m = c - r` changes by `u - w`. A state is allowed when `m >= 0`,
including equality.

For a nonnegative integer horizon `H`, the required initial margin is
`H * max(0, W - U)`. The maximum horizon for a nonnegative initial margin is
`m0 // (W - U)` when `W > U`; otherwise `max_horizon` returns `None`, meaning
no finite horizon limit under these assumptions. `can_maintain` includes the
initial state and returns `False` for a negative initial margin.
`max_horizon` rejects a negative initial margin with `ValueError`.

`margin` and `transition` use nonnegative integer capacities and demands.
`required_margin` and `can_maintain` require nonnegative integer bounds and
horizons; `max_horizon` requires nonnegative integer bounds. Noninteger
arguments to the integer checks raise `TypeError`; negative values rejected
by the nonnegative checks raise `ValueError`. `simulate` returns the initial
row and each successive row `(step, capacity, demand, margin, allowed)`, even
after the margin becomes negative. It requires equal-length increase and
disturbance sequences; a length mismatch raises `ValueError`. The caller
supplies sequences within the desired bounds, since `transition` and
`simulate` do not take `U` and `W` as arguments.

The fixed sample uses capacity 120, demand 100, `U = 20`, `W = 30`, and five
updates with the maximum addition and demand increase at every step. The
margin falls from 20 to -30; the first disallowed state is step 3. The required margin for five
periods is 50 and the maximum maintainable horizon is 2.

## Validation

`test_capacity.py` contains seven standard-library unit tests. They check the
fixed transitions and allowed flags; finite horizons 0, 1, 2, and 3; 100
updates in the three cases with no finite horizon limit; the required-margin
boundary at 49, 50, and 51; zero horizons and negative initial margins; and
invalid integer arguments and mismatched sequence lengths.

The disturbance enumeration uses `U = 2`, `W = 3`, and `H = 3`, with initial
margins 2, 3, and 4. It checks 64 sequences for each margin and requires all
states to be allowed for margins 3 and 4, but not for margin 2. The recursive
check enumerates the permitted additions and all demand increases, comparing
its result with the closed form for 768 combinations: initial margins -1
through 10, bounds 0 through 3, and horizons 0 through 3. This checks the
implementation independently of the closed-form calculation over those
finite ranges.

## Limitations

The guarantee concerns capacity relative to demand at discrete states under
the specified bounds. It does not guarantee real service availability,
response times, or queue lengths. Capacity provisioning delays, total
resource limits, demand outside the specified range, and costs are outside
the model. No finite test range establishes a theorem for arbitrary inputs.

## Files

- `capacity.py`: state updates, margin and horizon calculations, and sample.
- `test_capacity.py`: seven unit tests for the model and its implementation.
