#!/usr/bin/env python
# - * - coding: utf-8 - * -

try: xrange
except: xrange = range

def get_divisor(number):
    l = []
    for cnt in range(1,number):
        if number % (cnt) == 0:
            l.append(cnt)
    return l

def is_complete(number):
    multi = 0
    for num in get_divisor(number):
        multi += num
    if multi == number: return True;
    else: return False;

if __name__ == "__main__":
    #import doctest
    #doctest.testmod()
    for cnt in xrange(1,1001):
        if is_complete(cnt):
            print(cnt)

