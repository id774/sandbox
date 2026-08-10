#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Produce a sequence of values from a generator function with yield.

def yieldtest():
    for i in range(10):
        yield (10 + i)

if __name__ == '__main__':
    for j in yieldtest():
        print(j)
