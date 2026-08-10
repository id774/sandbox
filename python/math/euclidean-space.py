#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Euclidean distance
# http://en.wikipedia.org/wiki/Euclidean_space

# Find the distance between two points in a multidimensional space

def euclidean(p, q):
    sumSq = 0.0
    # Add up the squared differences
    for i in range(len(p)):
        sumSq += (p[i] - q[i]) ** 2
    # Square root
    return (sumSq ** 0.5)

# print euclidean([3,4,5],[4,5,6])
