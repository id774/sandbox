# forced_mate.py: Verify reachability and forced mate in a finite-state game
#
# Description:
# Compare graph reachability with forced mate using alternating attacker and
# defender choices, fixed-point iteration, and rank-decrease assertions.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     python3 -B python/forced_mate_reachability/forced_mate.py
#
# Requirements:
#   - Python 3.10 or later (verified with Python 3.13.5)
#   - Python standard library only
#   - Assertions must be enabled (do not use -O).

from collections import deque


SUCCESSORS = {
    "A0": ("D1", "D2"),
    "D1": ("A1", "A2"),
    "A1": ("M",),
    "A2": ("M",),
    "D2": ("A3", "A5"),
    "A3": ("D2",),
    "A5": ("M",),
    "A4": ("E",),
    "M": (),
    "E": (),
}

TURN = {
    "A0": "attacker",
    "A1": "attacker",
    "A2": "attacker",
    "A3": "attacker",
    "A4": "attacker",
    "A5": "attacker",
    "D1": "defender",
    "D2": "defender",
}

MATE = {"M"}
OTHER_TERMINAL = {"E"}
TERMINAL = MATE | OTHER_TERMINAL


def validate_graph():
    assert len(SUCCESSORS) == 10
    assert sum(len(children) for children in SUCCESSORS.values()) == 11
    assert set(SUCCESSORS) == set(TURN) | TERMINAL
    assert set(TURN).isdisjoint(TERMINAL)
    assert MATE.isdisjoint(OTHER_TERMINAL)

    for state, children in SUCCESSORS.items():
        assert all(child in SUCCESSORS for child in children)
        if state in TERMINAL:
            assert not children
        else:
            assert children
            for child in children:
                if child in TURN:
                    assert TURN[state] != TURN[child]


def reachable_mate(start):
    queue = deque([start])
    visited = set()

    while queue:
        state = queue.popleft()
        if state in visited:
            continue
        visited.add(state)
        if state in MATE:
            return True
        queue.extend(SUCCESSORS[state])

    return False


def forced_mate():
    winning = set(MATE)
    rank = {state: 0 for state in MATE}
    depth = 0

    while True:
        added = set()
        for state, turn in TURN.items():
            if state in winning:
                continue
            children = SUCCESSORS[state]
            if turn == "attacker":
                accepted = any(child in winning for child in children)
            else:
                accepted = bool(children) and all(
                    child in winning for child in children
                )
            if accepted:
                added.add(state)

        if not added:
            break
        depth += 1
        winning.update(added)
        rank.update({state: depth for state in added})

    return winning, rank


def main():
    validate_graph()
    winning, rank = forced_mate()

    assert winning == {"M", "A1", "A2", "A5", "D1", "A0"}
    assert rank == {
        "M": 0,
        "A1": 1,
        "A2": 1,
        "A5": 1,
        "D1": 2,
        "A0": 3,
    }
    assert reachable_mate("A0")
    assert reachable_mate("A3")
    assert reachable_mate("D2")
    assert not reachable_mate("A4")
    assert not reachable_mate("E")
    assert "A3" not in winning and "D2" not in winning
    assert "A4" not in winning and "E" not in winning

    for state in winning - MATE:
        children = SUCCESSORS[state]
        if TURN[state] == "attacker":
            assert any(
                child in rank and rank[child] < rank[state]
                for child in children
            )
        else:
            assert all(rank[child] < rank[state] for child in children)

    for state in ("A0", "A3", "D2", "A4"):
        print(
            f"{state}: reachable={reachable_mate(state)}, "
            f"forced={state in winning}"
        )
    print("winning:", ", ".join(sorted(winning)))
    print("ranks:", ", ".join(f"{s}={rank[s]}" for s in sorted(rank)))
    print("all assertions passed")


if __name__ == "__main__":
    main()
