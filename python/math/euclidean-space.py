#!/usr/bin/env python
# -*- coding: utf-8 -*-
# euclidean-space.py: Euclidean distance between two points
#
# Description:
# Define euclidean(p, q), which returns the Euclidean distance between two
# points of any dimension. The file defines the function only; its example
# call is commented out.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#

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
