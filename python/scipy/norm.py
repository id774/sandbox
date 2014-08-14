#!/usr/bin/env python
# -*- coding:utf-8 -*-

from scipy.stats import norm

print(norm.mean(), norm.std(), norm.var())

r = norm.rvs(size=100)
print(r)

print(r.mean(), r.std(), r.var())
