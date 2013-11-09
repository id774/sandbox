#!/usr/bin/env python
# -*- coding: utf-8 -*-

def f(x):
    return x ** 3

def closure(x):
   y = lambda x: x ** 3
   return (y(x))

if __name__=='__main__':
    x = 5
    print (f(x))
    print (closure(x))

