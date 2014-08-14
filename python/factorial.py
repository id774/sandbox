#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
>>> import factorial
>>> factorial.factorial(10)
3628800
"""

def factorial(n):
    if n == 1:
        return 1
    else:
        return n * factorial(n - 1)

if __name__ == '__main__':
    import doctest
    doctest.testmod()
    print(factorial(10))
