#!/usr/bin/env python
# -*- coding: utf-8 -*-

# ユークリッド空間
# http://en.wikipedia.org/wiki/Euclidean_space

def euclidean(p,q):
    sumSq=0.0
    # 差の平方を加算
    for i in range(len(p)):
        sumSq+=(p[i]-q[i])**2
    # 平方根
    return (sumSq**0.5)

print euclidean([3,4,5],[4,5,6])
