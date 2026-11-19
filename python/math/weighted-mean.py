#!/usr/bin/env python
# -*- coding: utf-8 -*-
# weighted-mean.py: Weighted mean components
#
# Description:
# Define weighted_mean(x, w), which returns the weighted sum and the sum of
# the weights as a pair. The file defines the function only; its example call
# is commented out.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#

# Weighted mean
# http://en.wikipedia.org/wiki/Weighted_mean

def weighted_mean(x, w):
    num = sum([x[i] * w[i] for i in range(len(w))])
    den = sum([w[i] for i in range(len(w))])
    return num, den

# print weighted_mean([3,4,5],[4,5,8])
