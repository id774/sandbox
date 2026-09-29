#!/usr/bin/env python3
# quicksort.py: Quicksort of a fixed integer sequence
#
# Description:
# Sort a fixed list with a quicksort over the head and tail of the list.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 quicksort.py
#
# Requirements:
# - Python 3.10 or later
# - No third-party package is required


def quicksort(items):
    if len(items) <= 1:
        return list(items)

    pivot, *rest = items
    smaller = [x for x in rest if x <= pivot]
    larger = [x for x in rest if x > pivot]
    return quicksort(smaller) + [pivot] + quicksort(larger)


print(" ".join(str(value) for value in quicksort([5, 3, 8, 4, 2, 7, 1, 10, 9, 6])))
