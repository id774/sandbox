#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

def product(a, b, c):
    return a * b * c

if __name__=='__main__':
    arr = [2, 3, 5]
    print (product(*arr))

    print (product(2, *arr[1:]))

