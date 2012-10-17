#!/usr/bin/env python
# -*- coding: utf-8 -*-

def comb(n, r):
    if n == 0 or r == 0: return 1
    return comb(n, r - 1) * (n - r + 1) / r

def binomial(n, p):
    t = 0.0
    for k in xrange(n + 1):
        b = comb(n, k) * p ** k * (1 - p) ** (n - k)
        t += b
        print "%d,\t%g,\t%g" % (k, b, t)

if __name__ == '__main__':
    binomial(5, 1/6.0)

