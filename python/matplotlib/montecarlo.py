# -*- coding:utf-8 -*-

from pylab import *
from scipy.stats import *
import matplotlib.pyplot as plt

runs = 10000

teamperfA = [0.9, 0.8, 0,9]
teamperfB = [0.9, 0.8, 0.9]

teamvarianceA = [0.03, 0.04, 0.02]
teamvarianceB = [0.05, 0.08, 0.09]

weights = [1.0, 0.95, 0.8]

def result(perf,variance,weights):
    res = 0.0
    for i in range(len(perf)-1):
        res += perf[i] * weights[i] * norm(1,variance[i]).rvs()
    return res

resultsA = zeros(shape=(runs,), dtype=float)
resultsB = zeros(shape=(runs,), dtype=float)

for i in range (runs):
    resultsA[i] = result (teamperfA, teamvarianceA, weights)
    resultsB[i] = result (teamperfB, teamvarianceB, weights)

subplot(211)
width = 2
height=runs

title('Team A')
hist(resultsA, bins=50)
axis([1.4, 1.9, 0, height/10])

subplot(212)
title('Team B')
hist(resultsB, bins=50)

axis([1.4, 1.9, 0, height/10])

show()
plt.savefig("image.png")
