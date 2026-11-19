#!/usr/bin/env python
# -*- coding: utf-8 -*-
# standard-deviation.py: Mean and standard deviation computed by hand
#
# Description:
# Compute the mean and standard deviation of a sequence by hand.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 standard-deviation.py
#
# Requirements:
# - Python 3
#

import math

def mean_sd(buff):
    n = len(buff)
    m = float(sum(buff)) / n
    s1 = 0.0
    for x in buff:
        a = x - m
        s1 += a * a
    s1 = math.sqrt(s1 / n)
    return m, s1

if __name__ == '__main__':
    a = [4, 4, 5, 5, 5, 6, 6, 6, 7, 7]
    b = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    for x in [a, b]:
        print("MEAN = %g, SD = %g" % mean_sd(x))
