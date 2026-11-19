#!/usr/bin/env python
# - * - coding: utf-8 - * -
# permutation.py: Recursive permutations with yield
#
# Description:
# Generate every permutation of a sequence recursively with yield.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 permutation.py
#
# Requirements:
# - Python 3
#

def permutations(seq):
    if len(seq) <= 1:
        yield seq
    else:
        for perm in permutations(seq[1:]):
            for i in range(len(perm) + 1):
                yield perm[:i] + seq[0:1] + perm[i:]

def main():
    print(list(permutations(['a', 'b', 'c', 'd'])))

if __name__ == '__main__':
    main()
