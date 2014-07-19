#!/usr/bin/env python
# - * - coding: utf-8 - * -

from nose.tools import *
from factorial import *

def test_factorial():
    i = 10
    e = 3628800
    eq_(e, factorial(i))

