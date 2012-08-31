#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
>>> import factorial
>>> factorial.factorial(10)
3628800
"""

def factorial_2(n):
    result = 1
    for i in range(n):
        result *= (i+1)
    return result

def factorial(n):
    if n==1:
        return 1
    else:
        return n * factorial(n-1)

def main():
    print factorial_2(10)
    print factorial(10)

if __name__=='__main__':
    import doctest
    doctest.testmod()
    main()

