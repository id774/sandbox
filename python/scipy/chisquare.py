# -*- coding: utf-8 -*-
# Run a chi-squared test of independence on a contingency matrix.

import scipy as sp
from scipy import stats

def chisquare_test(array):
    '''Run a chi-squared test on a matrix'''
    (num_row, num_col) = sp.shape(array)
    df = (num_row - 1) * (num_col - 1)
    ch2 = _get_chisquare(array)
    pval = 1 - stats.chi2.cdf(ch2, df)
    return ch2, pval

def _get_chisquare(array):
    '''Compute the chi-squared statistic'''
    sum_cols = array.sum(axis=0)
    sum_rows = array.sum(axis=1)
    N = array.sum()
    chi2 = 0.0
    (num_row, num_col) = sp.shape(array)
    for i in range(num_row):
        for j in range(num_col):
            observation = array[i, j]
            expectation = 1.0 * sum_rows[i] * sum_cols[j] / N
            chi2 += 1.0 * (observation - expectation) ** 2 / expectation
    return chi2
