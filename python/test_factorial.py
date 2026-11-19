#!/usr/bin/env python
# - * - coding: utf-8 - * -
# test_factorial.py: nose test for the factorial function
#
# Description:
# Test the factorial function in factorial.py with nose.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     nosetests test_factorial.py
#
# Requirements:
# - Python 3
# - nose
#

from nose.tools import *
from factorial import *

def test_factorial():
    i = 10
    e = 3628800
    eq_(e, factorial(i))
