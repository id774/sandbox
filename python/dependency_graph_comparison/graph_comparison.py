# graph_comparison.py: Compare dependency graph candidate and edge counts
#
# Description:
#   Generate complete and path graph edges for fixed vertex counts and check
#   their edge counts against formulas without enumerating all possible graphs.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     python3 -B python/dependency_graph_comparison/graph_comparison.py
#
# Requirements:
#   - Python 3.12 or later
#   - Python standard library only
#   - Assertions enabled (do not use -O).

from itertools import combinations
from math import comb


def complete_graph_edges(n):
    return list(combinations(range(n), 2))


def path_graph_edges(n):
    return [(i, i + 1) for i in range(n - 1)]


def compare(n):
    possible_edges = comb(n, 2)
    graph_candidates = 2 ** possible_edges
    complete = complete_graph_edges(n)
    path = path_graph_edges(n)

    assert len(complete) == possible_edges
    assert len(path) == n - 1
    assert len(set(complete)) == len(complete)
    assert len(set(path)) == len(path)
    assert all(0 <= a < b < n for a, b in complete + path)
    assert all(b == a + 1 for a, b in path)

    print(
        f"{n:>2} | {graph_candidates} | "
        f"{len(complete):>3} | {len(path):>3}"
    )


print(" n | graph_candidates | complete_edges | path_edges")
for n in (4, 10, 20):
    compare(n)
