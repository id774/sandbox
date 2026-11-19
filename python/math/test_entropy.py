#!/usr/bin/env python
# - * - coding: utf-8 - * -
# test_entropy.py: nose test for the entropy helper
#
# Description:
# Test the entropy helper against a known value with nose.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     nosetests test_entropy.py
#
# Requirements:
# - Python 2, which entropy.py requires
# - nose and NLTK
#

from nose.tools import *
from entropy import *

def test_entropy():
    i = (['male', 'male', 'female', 'male'])
    e = 0.81127812445913283
    eq_(e, entropy(i))
