# -*- coding: utf-8 -*-

import numpy as np
from pandas import *
from statsmodels.tsa import stattools
import matplotlib.pyplot as plt

randn = np.random.randn

ts = Series(randn(1000), index = DateRange('2000/1/1', periods = 1000))
ts = ts.cumsum()

ts.plot(style = '<--')
rolling_mean(ts, 60).plot(style='--', c='r')
rolling_mean(ts, 180).plot(style='--', c='b')

acf = stattools.acf(np.array(ts), 50)
plt.bar(range(len(acf)), acf, width = 0.01)
plt.savefig("image.png")

pcf = stattools.pacf(np.array(ts), 50)
plt.bar(range(len(pcf)), pcf, width = 0.01) 
plt.show()
plt.savefig("image2.png")

