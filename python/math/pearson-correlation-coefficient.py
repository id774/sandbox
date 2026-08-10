#!/usr/bin/env python
# -*- coding: utf-8 -*-

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
