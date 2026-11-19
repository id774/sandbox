#!/usr/bin/env python
# -*- coding:utf-8 -*-
# norm.py: Standard normal samples against distribution moments
#
# Description:
# Draw standard normal samples and compare them with the distribution moments.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 norm.py
#
# Requirements:
# - Python 3
# - SciPy
#

from scipy.stats import norm

print(norm.mean(), norm.std(), norm.var())

r = norm.rvs(size=100)
print(r)

print(r.mean(), r.std(), r.var())
