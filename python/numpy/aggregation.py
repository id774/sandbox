# -*- coding:utf-8 -*-
# Generate normal random samples and report their summary statistics.

import numpy
from scipy import stats

n = 400
# Generate random numbers from a normal distribution
X = numpy.random.normal(171.77, 5.54, n)
Y = numpy.random.normal(62.49, 7.89, n)

X.sort()
X = numpy.around(X + numpy.random.normal(scale=3.0, size=n), 2)
Y.sort()
Y = numpy.around(Y + numpy.random.normal(size=n), 2)

print(X)
print(Y)

# Maximum
print("最大値 Max x: " + str(numpy.max(X)) + " y: " + str(numpy.max(Y)))
# Minimum
print("最小値 Min x: " + str(numpy.min(X)) + " y: " + str(numpy.min(Y)))
# Mean
print("平均 Avg x: " + str(numpy.mean(X)) + " y: " + str(numpy.mean(Y)))
# First quartile
print("第 1 四分位 1Q x:" + str(stats.scoreatpercentile(X, 25)) +
      " y: " + str(stats.scoreatpercentile(Y, 25)))
# Median
print("中央値 Med x: " + str(numpy.median(X)) + " y: " + str(numpy.median(Y)))
# Third quartile
print("第 3 四分位 3Q x:" + str(stats.scoreatpercentile(X, 75)) +
      " y: " + str(stats.scoreatpercentile(Y, 75)))
# Variance
print("分散 Var x: " + str(numpy.var(X)) + " y: " + str(numpy.var(Y)))
# Standard deviation
print("標準偏差 S.D. x: " + str(numpy.std(X)) + " y:" + str(numpy.std(Y)))
# Correlation coefficient
cor = numpy.corrcoef(X, Y)
print("相関係数 Correlation Coefficient: " + str(cor[0, 1]))
