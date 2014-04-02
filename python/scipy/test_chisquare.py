# -*- coding: utf-8 -*-
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
