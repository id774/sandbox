# -*- coding: utf-8 -*-
# test_chisquare.py: nose test for the chisquare helper
#
# Description:
# Test the chisquare helper against known values with nose.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     nosetests test_chisquare.py
#
# Requirements:
# - Python 3
# - nose
# - SciPy from a release whose top-level namespace still provides NumPy
#   aliases such as scipy.array
#

from nose.tools import *
import chisquare
import scipy as sp

def test_chisquare_test():
    array = sp.array([[435, 165],
                      [265, 135]])
    (ch2, pval) = chisquare.chisquare_test(array)
    assert_almost_equal(ch2, 4.46, 2)
    assert_almost_equal(pval, 0.03, 2)

if __name__ == "__main__":
    test_chisquare_test()
