# leakage_audit.py: Measure information leakage across joint observations
#
# Description:
# Compare marginal, joint, and conditional mutual information for four
# fixed binary probability distributions.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
# python3 -B python/joint_observation_leakage/leakage_audit.py
#
# Requirements:
# - Python 3.9 or later for the experiment and its tests
# - Python standard library only
#
# Verified Environment:
# Tested with Python 3.13.5.

from collections import defaultdict
from itertools import product
from math import fsum, isclose, isfinite, log2

TOL = 1e-12
STATES = tuple(product((0, 1), repeat=3))
# Tuple order: (A, Z1, Z2), lexicographic.
WEIGHTS = {
    "C01": (1, 1, 1, 1, 1, 1, 1, 1),
    "C02": (2, 2, 0, 0, 0, 0, 2, 2),
    "C03": (2, 0, 0, 2, 0, 2, 2, 0),
    "C04": (4, 0, 0, 0, 0, 0, 0, 4),
}


def validate_distribution(distribution):
    if set(distribution) != set(STATES):
        raise ValueError("Expected all eight binary states")
    if any(not isfinite(p) or p < 0 or p > 1
           for p in distribution.values()):
        raise ValueError("Invalid probability")
    if not isclose(fsum(distribution.values()), 1.0,
                   rel_tol=0.0, abs_tol=TOL):
        raise ValueError("Probabilities must sum to one")


def make_distribution(case):
    distribution = dict(zip(STATES, (w / 8 for w in WEIGHTS[case])))
    validate_distribution(distribution)
    return distribution


def marginalize(distribution, axes):
    # Each axis is one of 0 (A), 1 (Z1), 2 (Z2).
    groups = defaultdict(list)
    for state, probability in distribution.items():
        key = tuple(state[i] for i in axes)
        groups[key].append(probability)
    return {key: fsum(values) for key, values in groups.items()}


def entropy(distribution, axes):
    probabilities = marginalize(distribution, axes).values()
    return -fsum(p * log2(p) for p in probabilities if p > 0)


def mutual_information(distribution, x, y):
    return fsum((entropy(distribution, x), entropy(distribution, y),
                 -entropy(distribution, x + y)))


def conditional_mutual_information(distribution, x, y, given):
    return fsum((entropy(distribution, x + given),
                 entropy(distribution, y + given),
                 -entropy(distribution, given),
                 -entropy(distribution, x + y + given)))


def evaluate(distribution):
    validate_distribution(distribution)
    return (
        mutual_information(distribution, (0,), (1,)),
        mutual_information(distribution, (0,), (2,)),
        mutual_information(distribution, (0,), (1, 2)),
        conditional_mutual_information(distribution, (0,), (2,), (1,)),
    )


def main():
    print("case  I(A;Z1)  I(A;Z2)  joint  additional  sum")
    for case in WEIGHTS:
        first, second, joint, additional = evaluate(make_distribution(case))
        print(f"{case}   {first:.3f}    {second:.3f}    "
              f"{joint:.3f}    {additional:.3f}       {first + second:.3f}")


if __name__ == "__main__":
    main()
