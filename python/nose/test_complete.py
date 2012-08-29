#!/usr/bin/env python
# - * - coding: utf-8 - * -

from nose.tools import *
from complete import *
#from tempfile import *

def test_get_divisor():
    i=6
    e=[1,2,3]
    eq_(e,get_divisor(i))

def test_get_divisor2():
    i=7
    e=[1]
    eq_(e,get_divisor(i))

def test_get_divisor3():
    i=100
    e=[1, 2, 4, 5, 10, 20, 25, 50]
    eq_(e,get_divisor(i))

def test_get_divisor4():
    i=200
    e=[1, 2, 4, 5, 8, 10, 20, 25, 40, 50, 100]
    eq_(e,get_divisor(i))

def test_get_divisor5():
    i=44
    e=[1, 2, 4, 11, 22]
    eq_(e,get_divisor(i))

def test_is_complete():
    i=6
    e=True
    eq_(e,is_complete(i))

def test_is_complete2():
    i=28
    e=True
    eq_(e,is_complete(i))

def test_is_complete3():
    i=28
    e=True
    eq_(e,is_complete(i))

def test_is_complete4():
    i=4
    e=False
    eq_(e,is_complete(i))

def test_is_complete5():
    i=496
    e=True
    eq_(e,is_complete(i))

def test_is_complete6():
    i=7
    e=False
    eq_(e,is_complete(i))

