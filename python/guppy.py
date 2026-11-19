#!/usr/bin/env python
# -*- coding: utf-8 -*-
# guppy.py: Measure heap usage with guppy
#
# Description:
# Measure heap usage with guppy after allocating 100000 objects, and print the
# heap summary.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 guppy.py
#
# Requirements:
# - Python 3
# - guppy3, which provides the guppy package for Python 3
#

from guppy import hpy
h = hpy()
N = 100000

class Hoge(object):

    def __init__(self):
        self.x = 1
        self.y = 1
        self.z = 1
        self.a = 1
        self.b = 1
        self.c = 1

x = [Hoge() for x in range(N)]

print(h.heap())
