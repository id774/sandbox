#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

def chi2(count):
    total = 0.0
    xn = len(count)
    yn = len(count[0])
    xcount = [0] * xn
    ycount = [0] * yn
    for x in xrange(xn):
        for y in xrange(yn):
            a = count[x][y]
            total += a
            xcount[x] += a
            ycount[y] += a

    v = 0.0
    for x in xrange(xn):
        for y in xrange(yn):
            F = xcount[x] * ycount[y] / total
            a = count[x][y] - F
            v += a * a / F
    return v

