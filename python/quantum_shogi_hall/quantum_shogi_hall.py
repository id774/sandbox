# quantum_shogi_hall.py: Project quantum shogi kind domains under capacity constraints
#
# Description:
# Check Hall's capacity condition for 20 pieces and remove unsupported kinds
# by scanning the 255 nonempty subsets of eight piece kinds.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 -B quantum_shogi_hall.py
#
# Requirements:
# - Python 3.12 or later
# - Only the Python standard library is required
# - Run without -O so assertions in the examples are evaluated

KINDS = ("王", "飛", "角", "金", "銀", "桂", "香", "歩")
COUNTS = (1, 1, 1, 2, 2, 2, 2, 9)
BITS = {kind: 1 << i for i, kind in enumerate(KINDS)}
FULL = (1 << len(KINDS)) - 1


def mask(*kinds):
    result = 0
    for kind in kinds:
        result |= BITS[kind]
    return result


def names(bits):
    return tuple(kind for kind in KINDS if bits & BITS[kind])


def project(domains):
    """Project 20 piece domains onto globally supported kinds."""
    if len(domains) != sum(COUNTS):
        raise ValueError("駒数が初期陣営の容量合計と一致しません")
    if any(d == 0 or (d & ~FULL) != 0 for d in domains):
        raise ValueError("空候補または範囲外の候補ビットがあります")

    removed = [0] * len(domains)
    capacity = [0] * (FULL + 1)

    for t in range(1, FULL + 1):
        lowest = t & -t
        capacity[t] = (
            capacity[t ^ lowest]
            + COUNTS[lowest.bit_length() - 1]
        )

        inside = [i for i, d in enumerate(domains) if (d & ~t) == 0]
        if len(inside) > capacity[t]:
            raise ValueError("Hall の容量条件に違反しています")
        if len(inside) == capacity[t]:
            for i, d in enumerate(domains):
                if (d & ~t) != 0:
                    removed[i] |= t

    return [d & ~removed[i] for i, d in enumerate(domains)]


# Three domains exhaust one rook slot and two lance slots.
domains = [mask("飛", "香")] * 3 + [FULL] * 17
result = project(domains)
assert all(names(d) == ("飛", "香") for d in result[:3])
assert all((d & mask("飛", "香")) == 0 for d in result[3:])
assert project(result) == result

# Fixing one piece as a rook leaves two lances.
fixed = domains.copy()
fixed[0] = mask("飛")
fixed_result = project(fixed)
assert names(fixed_result[1]) == ("香",)
assert names(fixed_result[2]) == ("香",)

# Four pieces competing for three slots violate Hall's condition.
invalid = [mask("飛", "香")] * 4 + [FULL] * 16
try:
    project(invalid)
except ValueError as exc:
    assert str(exc) == "Hall の容量条件に違反しています"
else:
    raise AssertionError("容量超過を検出できませんでした")

print("候補の射影・冪等性・容量超過の検証: PASS")
