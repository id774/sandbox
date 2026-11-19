#!/usr/bin/env python
# -*- coding: utf-8 -*-
# gaussian-function.py: Gaussian function
#
# Description:
# Define gaussian(dist, sigma), the probability density of the normal
# distribution with mean 0 and standard deviation sigma, which defaults to
# 10.0. The file defines the function only; its example calls are commented
# out.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#

# Gaussian function
# http://en.wikipedia.org/wiki/Gaussian_function

# The probability density function of the normal distribution

import math
def gaussian(dist, sigma=10.0):
    exp = math.e ** (-dist ** 2 / (2 * sigma ** 2))
    return (1 / (sigma * (2 * math.pi) ** .5)) * exp

# print gaussian(0.1)
# print gaussian(1.0)
# print gaussian(5.0)
# print gaussian(0.0)
# print gaussian(3.0)
