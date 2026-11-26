# agent_workflow_reliability.py: Evaluate multi-stage workflow reliability
#
# Description:
# Compare analytical success probabilities and seeded simulations with
# single-attempt recovery, and calculate required stage and recovery rates.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   python3 -B python/agent_workflow_reliability/agent_workflow_reliability.py
#
# Requirements:
# - Python 3 interpreter with dataclasses and math.prod
# - Python standard library only
#
# Verified Environment:
# Tested with Python 3.13.5.
#
from dataclasses import dataclass
from math import prod, sqrt
from random import Random


def probability(value):
    if not 0 <= value <= 1:
        raise ValueError('probability must be in [0, 1]')
    return value


def positive_integer(value):
    if type(value) is not int or value < 1:
        raise ValueError('count must be a positive integer')
    return value


@dataclass(frozen=True)
class Stage:
    q: float
    d: float = 0.0
    r: float = 0.0

    def __post_init__(self):
        for value in (self.q, self.d, self.r):
            probability(value)

    def effective(self):
        return self.q + (1 - self.q) * self.d * self.r


def workflow(stages):
    stages = tuple(stages)
    positive_integer(len(stages))
    return stages


def theoretical(stages):
    return prod(s.effective() for s in workflow(stages))


def required_stage(target, n):
    return probability(target) ** (1 / positive_integer(n))


def required_recovery(q, target, n):
    q = probability(q)
    need = required_stage(target, n)
    if q >= need:
        return 0.0
    return (need - q) / (1 - q)


def run_once(stages, draw):
    for s in stages:
        if draw() < s.q:
            continue
        if draw() >= s.d:
            return False
        if draw() >= s.r:
            return False
    return True


def simulate(stages, trials=100_000, seed=42):
    stages = workflow(stages)
    positive_integer(trials)
    draw = Random(seed).random
    return sum(run_once(stages, draw) for _ in range(trials))


def tolerance(p, trials):
    return 5 * sqrt(p * (1 - p) / trials)


def report(group, label, stages, trials=100_000):
    p = theoretical(stages)
    count = simulate(stages, trials)
    observed = count / trials
    error = abs(observed - p)
    bound = tolerance(p, trials)
    assert error <= bound + 1e-15, (group, label)
    print(f'{group}|{label}|{p:.8f}|{count}|{observed:.8f}|'
          f'{error:.8f}|{bound:.8f}')


def main():
    print('group|condition|theory|successes|observed|error|5se')
    for n in (1, 5, 10, 20, 50):
        for q in (0.90, 0.95, 0.99):
            report('baseline', f'{n}, {q:.2f}', [Stage(q)] * n)
    for d in (0.0, 0.8, 1.0):
        for r in (0.0, 0.5, 0.9, 1.0):
            report('recovery', f'{d:.1f}, {r:.1f}',
                   [Stage(0.95, d, r)] * 20)
    cases = {
        'uniform': [Stage(0.99)] * 20,
        'bottleneck': [Stage(0.99)] * 19 + [Stage(0.80)],
        'recover_bottleneck': [Stage(0.99)] * 19
        + [Stage(0.80, 0.8, 0.9)],
    }
    for label, stages in cases.items():
        report('heterogeneous', label, stages)
    print(f'required_stage={required_stage(0.95, 20):.8f}')
    print(f'required_recovery={required_recovery(0.95, 0.95, 20):.8f}')


if __name__ == '__main__':
    main()
