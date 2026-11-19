#!/usr/bin/env python
# -*- coding: utf-8 -*-
# binomial-distribution.py: Binomial distribution table with a running total
#
# Description:
# Tabulate the binomial distribution and its running total; written for Python
# 2.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python binomial-distribution.py
#
# Requirements:
# - Python 2, whose print statement the source uses
#

def comb(n, r):
    if n == 0 or r == 0:
        return 1
    return comb(n, r - 1) * (n - r + 1) / r

def binomial(n, p):
    t = 0.0
    for k in xrange(n + 1):
        b = comb(n, k) * p ** k * (1 - p) ** (n - k)
        t += b
        print "%d,\t%g,\t%g" % (k, b, t)

if __name__ == '__main__':
    binomial(5, 1 / 6.0)
