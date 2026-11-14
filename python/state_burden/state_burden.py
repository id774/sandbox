# state_burden.py: Compare state convergence and persistent burden
#
# Description:
#   Compare state changes and burden in four discrete-time scenarios.
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From this directory:
#     python3 -B state_burden.py
# Requirements:
#   - Python 3.12 or later
#   - Python standard library only (dataclasses)

from dataclasses import dataclass


@dataclass(frozen=True)
class Case:
    name: str
    delta: float
    p: float
    q_max: float | None = None
    q0: float = 0.5
    eta: float = 0.2
    kappa: float = 1.0
    beta: float = 1.0

    @property
    def rho(self) -> float:
        return 1.0 + (self.eta * self.kappa - self.delta)


@dataclass(frozen=True)
class Sample:
    t: int
    q: float
    amplitude: float | None
    burden: float


CASES = (
    Case('decay', 0.3, 0.0),
    Case('fixed', 0.2, 0.0),
    Case('forced', 0.3, 0.2),
    Case('saturation', 0.1, 0.0, q_max=1.0),
)
STEPS = 100
EPS_AMPLITUDE = 1e-4
EPS_BURDEN = 1e-4


def update_state(q: float, case: Case) -> float:
    next_q = case.rho * q + case.eta * case.p
    if case.q_max is not None:
        next_q = min(case.q_max, next_q)
    return next_q


def measure_burden(q: float, case: Case) -> float:
    return case.beta * (case.p + case.kappa * q)


def simulate(case: Case, steps: int) -> list[Sample]:
    q = case.q0
    samples = [Sample(0, q, None, measure_burden(q, case))]
    for t in range(1, steps + 1):
        next_q = update_state(q, case)
        amplitude = abs(next_q - q)
        q = next_q
        samples.append(Sample(t, q, amplitude, measure_burden(q, case)))
    return samples


def evaluate(sample: Sample) -> tuple[bool, bool, bool]:
    if sample.amplitude is None:
        raise ValueError('amplitude is undefined at t=0')
    settled = sample.amplitude <= EPS_AMPLITUDE
    acceptable = sample.burden <= EPS_BURDEN
    accepted = settled and acceptable
    return settled, acceptable, accepted


def main() -> None:
    print('case          q_100        A_100        B_100        settled acceptable accepted')
    for case in CASES:
        last = simulate(case, STEPS)[-1]
        settled, acceptable, accepted = evaluate(last)
        print(
            f'{case.name:12s} {last.q:.9f}  {last.amplitude:.9f}  '
            f'{last.burden:.9f}  {str(settled):7s} '
            f'{str(acceptable):10s} {accepted}'
        )


if __name__ == '__main__':
    main()
