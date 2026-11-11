# structure.py: Measure directed graph changes in fixed binary edge states
#
# Description:
#   Encode a fixed six-edge directed graph and measure the amplitude,
#   signed edge-count change, and exact added or removed edges over four updates.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From this directory:
#     python3 -B structure.py
#
# Requirements:
#   - Python 3.8 or later
#   - Python standard library only (math)

"""Measure changes in a fixed directed binary graph."""

from math import dist

EDGE_ORDER = (
    ("A", "B"),
    ("B", "C"),
    ("C", "D"),
    ("A", "D"),
    ("B", "D"),
    ("A", "C"),
)

STATES = (
    frozenset(EDGE_ORDER[:3]),
    frozenset(EDGE_ORDER[:5]),
    frozenset(EDGE_ORDER[:4]),
    frozenset(EDGE_ORDER[:3]),
    frozenset((*EDGE_ORDER[:3], EDGE_ORDER[5])),
)


def encode(edges):
    """Return the binary vector in the fixed EDGE_ORDER."""
    edges = frozenset(edges)
    unknown = edges - frozenset(EDGE_ORDER)
    if unknown:
        raise ValueError(f"unknown edges: {sorted(unknown)}")
    return tuple(int(edge in edges) for edge in EDGE_ORDER)


def measure(before, after):
    """Return structural amplitude, signed edge count and exact changes."""
    before = frozenset(before)
    after = frozenset(after)
    x_before = encode(before)
    x_after = encode(after)
    added = after - before
    removed = before - after
    return {
        "vector": x_after,
        "amplitude": dist(x_before, x_after),
        "delta_edges": len(after) - len(before),
        "edge_count": len(after),
        "added": added,
        "removed": removed,
    }


def main():
    print("t  vector               edges  amplitude  delta")
    print(f"0  {str(encode(STATES[0])):<20} {len(STATES[0]):>5}  {'-':>9}  {'-':>5}")
    for t in range(1, len(STATES)):
        item = measure(STATES[t - 1], STATES[t])
        print(
            f"{t}  {str(item['vector']):<20} {item['edge_count']:>5}  "
            f"{item['amplitude']:>9.3f}  {item['delta_edges']:>+5}"
        )


if __name__ == "__main__":
    main()
