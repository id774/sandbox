#!/usr/bin/env python
# -*- coding: utf-8 -*-

def area(b, h):
    return 0.5 * b * h

print(area(10, 4))

area2 = lambda b, h: 0.5 * b * h

print(area2(10, 4))
