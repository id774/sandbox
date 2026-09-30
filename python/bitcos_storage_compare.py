#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# bitcos_storage_compare.py
#
# Description:
#   A standalone sample that compares how much storage ternary weights
#   (-1, 0, +1) need under two representations, BITCOS and five-trit packing.
#   For a fixed set of zero rates and a group size of 128 weights, it computes
#   bit/weight (bpw) for both and reports which one is smaller.
#
#   Storage model used here:
#     - BITCOS: bpw = 2.0 - zero_rate.
#       The cost starts at 2 bits per weight and decreases linearly as the
#       fraction of zero weights (zero_rate) grows.
#     - Five-trit packing: five trits are packed into one byte
#       (3^5 = 243 fits in 256 values), so a group of group_size weights uses
#       ceil(group_size / 5) bytes and bpw = bytes * 8 / group_size.
#       It does not depend on zero_rate. For 128 weights this is 26 bytes,
#       which is 208 bits, or 1.625 bpw.
#
#   Because the five-trit cost is constant and the BITCOS cost falls with the
#   zero rate, the two meet where 2.0 - zero_rate = 1.625, that is at
#   zero_rate = 0.375. Below it five-trit packing is smaller, above it BITCOS
#   is smaller. The four fixed zero rates (0.30, 0.375, 0.40, 0.515) cover
#   both sides of this crossover and the tie.
#
#   Output: one line per zero rate, in the form
#     z=<zero_rate> BITCOS=<bpw> five-trit=<bpw> smaller=<result>
#   where <result> is "BITCOS", "five-trit packing", or "same".
#
# Reference:
#   The formulas follow the following research:
#   Evangelos Georganas, Alexander Heinecke, Pradeep Dubey,
#   "Breaking the 1.58-bit Barrier for Ternary LLMs",
#   https://arxiv.org/abs/2609.16338
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   python3 bitcos_storage_compare.py
#
# Requirements:
#   - Python 3.9 or later
#   - No third-party package is required

import math


def compare_storage(
    zero_rate: float,
    group_size: int = 128,
) -> tuple[float, float, str]:
    if not 0.0 <= zero_rate <= 1.0:
        raise ValueError("zero_rate must be between 0.0 and 1.0")
    if group_size <= 0:
        raise ValueError("group_size must be positive")

    bitcos_bpw = 2.0 - zero_rate
    five_trit_bytes = math.ceil(group_size / 5)
    five_trit_bpw = five_trit_bytes * 8 / group_size

    if bitcos_bpw < five_trit_bpw:
        result = "BITCOS"
    elif bitcos_bpw > five_trit_bpw:
        result = "five-trit packing"
    else:
        result = "same"

    return bitcos_bpw, five_trit_bpw, result


def main() -> None:
    for zero_rate in (0.30, 0.375, 0.40, 0.515):
        bitcos, five_trit, result = compare_storage(zero_rate)
        print(
            f"z={zero_rate:.3f} "
            f"BITCOS={bitcos:.3f} "
            f"five-trit={five_trit:.3f} "
            f"smaller={result}"
        )


if __name__ == "__main__":
    main()
