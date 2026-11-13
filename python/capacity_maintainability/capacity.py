# capacity.py: Compute capacity margins and finite-horizon maintainability
#
# Description:
#   Compute capacity margins and finite-horizon maintainability.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From this directory:
#     python3 -B capacity.py
# Requirements:
#   - Python 3.12 or later
#   - Python standard library only

"""Compute capacity margins in a discrete-time model."""


def _require_int(value: int, name: str) -> None:
    if type(value) is not int:
        raise TypeError(f"{name} must be an integer")


def _require_nonnegative(value: int, name: str) -> None:
    _require_int(value, name)
    if value < 0:
        raise ValueError(f"{name} must be nonnegative")


def margin(capacity: int, demand: int) -> int:
    _require_nonnegative(capacity, "capacity")
    _require_nonnegative(demand, "demand")
    return capacity - demand


def transition(
    capacity: int, demand: int, increase: int, disturbance: int
) -> tuple[int, int]:
    margin(capacity, demand)
    _require_nonnegative(increase, "increase")
    _require_nonnegative(disturbance, "disturbance")
    return capacity + increase, demand + disturbance


def required_margin(U: int, W: int, H: int) -> int:
    _require_nonnegative(U, "U")
    _require_nonnegative(W, "W")
    _require_nonnegative(H, "H")
    return H * max(0, W - U)


def can_maintain(m0: int, U: int, W: int, H: int) -> bool:
    _require_int(m0, "m0")
    return m0 >= required_margin(U, W, H)


def max_horizon(m0: int, U: int, W: int) -> int | None:
    _require_nonnegative(m0, "m0")
    _require_nonnegative(U, "U")
    _require_nonnegative(W, "W")
    if U >= W:
        return None
    return m0 // (W - U)


def simulate(
    capacity: int,
    demand: int,
    increases: list[int],
    disturbances: list[int],
) -> list[tuple[int, int, int, int, bool]]:
    m = margin(capacity, demand)
    rows = [(0, capacity, demand, m, m >= 0)]
    for t, (u, w) in enumerate(
        zip(increases, disturbances, strict=True), start=1
    ):
        capacity, demand = transition(capacity, demand, u, w)
        m = margin(capacity, demand)
        rows.append((t, capacity, demand, m, m >= 0))
    return rows


def main() -> None:
    capacity, demand = 120, 100
    U, W, H = 20, 30, 5
    rows = simulate(capacity, demand, [U] * H, [W] * H)
    print("step capacity demand margin allowed")
    for t, c, r, m, allowed in rows:
        print(f"{t:<4} {c:<8} {r:<6} {m:<6} {allowed}")
    print()
    print(f"Required margin for {H} periods: {required_margin(U, W, H)}")
    horizon = max_horizon(margin(capacity, demand), U, W)
    print(f"Maximum maintainable periods: {horizon}")


if __name__ == "__main__":
    main()
