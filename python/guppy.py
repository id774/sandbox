#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Measure heap usage with guppy after allocating 100000 objects.

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
