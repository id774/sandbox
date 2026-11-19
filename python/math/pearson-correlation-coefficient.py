#!/usr/bin/env python
# -*- coding: utf-8 -*-
# pearson-correlation-coefficient.py: Pearson correlation coefficient computed by hand
#
# Description:
# Define pearson(x, y), which returns the Pearson correlation coefficient of
# two sequences, or 0 when the denominator is 0. The file defines the function
# only; its example call is commented out.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#

# Pearson correlation
# http://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient

# A measure of how strongly two variables correlate
# It runs from -1 to 1: 1 when fully correlated, 0 when uncorrelated, -1 when inversely correlated

def pearson(x, y):
    n = len(x)
    vals = range(n)

    # Plain sums
    sumx = sum([float(x[i]) for i in vals])
    sumy = sum([float(y[i]) for i in vals])

    # Sums of squares
    sumxSq = sum([x[i] ** 2.0 for i in vals])
    sumySq = sum([y[i] ** 2.0 for i in vals])

    # Sum of products
    pSum = sum([x[i] * y[i] for i in vals])

    # Compute the Pearson score
    num = pSum - (sumx * sumy / n)
    den = ((sumxSq - pow(sumx, 2) / n) * (sumySq - pow(sumy, 2) / n)) ** .5
    if den == 0:
        return 0
    r = num / den
    return r

# print pearson([3,4,5],[4,5,8])
