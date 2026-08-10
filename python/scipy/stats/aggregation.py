# -*- coding:utf-8 -*-

# https://gist.github.com/mia-0032/6309113

import numpy
from scipy import stats

n = 200

# Generate random numbers from a normal distribution
score_x = numpy.random.normal(171.77, 5.54, n)
score_y = numpy.random.normal(62.49, 7.89, n)

# Add a little noise
score_x.sort()
score_x = numpy.around(score_x + numpy.random.normal(scale=3.0, size=n), 2)
score_y.sort()
score_y = numpy.around(score_y + numpy.random.normal(size=n), 2)

# Maximum
print("Max x: " + str(numpy.max(score_x)) + " y: " + str(numpy.max(score_y)))
# Minimum
print("Min x: " + str(numpy.min(score_x)) + " y: " + str(numpy.min(score_y)))
# Mean
print("Avg x: " + str(numpy.mean(score_x)) + " y: " + str(numpy.mean(score_y)))
# First quartile
print("1Q x:" + str(stats.scoreatpercentile(score_x, 25)) +
      " y: " + str(stats.scoreatpercentile(score_y, 25)))
# Median
print("Med x: " + str(numpy.median(score_x)) +
      " y: " + str(numpy.median(score_y)))
# Third quartile
print("3Q x:" + str(stats.scoreatpercentile(score_x, 75)) +
      " y: " + str(stats.scoreatpercentile(score_y, 75)))
# Variance
print("Var x: " + str(numpy.var(score_x)) + " y: " + str(numpy.var(score_y)))
# Standard deviation
print("S.D. x: " + str(numpy.std(score_x)) + " y:" + str(numpy.std(score_y)))
# Correlation coefficient
cor = numpy.corrcoef(score_x, score_y)
print("Correlation Coefficient : " + str(cor[0, 1]))
