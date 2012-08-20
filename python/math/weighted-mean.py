#!/usr/bin/env python
# -*- coding: utf-8 -*-

# 加重平均
# http://en.wikipedia.org/wiki/Weighted_mean

def weighted_mean(x,w):
    num=sum([x[i]*w[i] for i in range(len(w))])
    den=sum([w[i] for i in range(len(w))])
    return num,den

print weighted_mean([3,4,5],[4,5,8])
