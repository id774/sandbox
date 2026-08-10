#!/usr/bin/env python
# - * - coding: utf-8 - * -
# Test the entropy helper against a known value with nose.

from nose.tools import *
from entropy import *

def test_entropy():
    i = (['male', 'male', 'female', 'male'])
    e = 0.81127812445913283
    eq_(e, entropy(i))
