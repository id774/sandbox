#!/usr/bin/env python

import matplotlib.pyplot as plt
import numpy as np
import scipy.optimize

lim = 10000

def gaussian_func(x,x0,peak,sigma):
    return peak*np.exp(-(x-x0)**2/(2*sigma**2))

def err_func(para,x,data):
    calc=gaussian_func(x,para[0],para[1],para[2])
    return calc-data

noise = np.random.normal(size=10000)
(_hist, bins, line,) = plt.hist(noise,bins=40)
x = 0.5 * bins[1:] + 0.5 * bins[:-1]
para, _ind = scipy.optimize.leastsq(err_func, [0,1000,1], args=(x,_hist))
_mid = para[0]
_max = para[1]
_sd  = para[2]

print( "中心値は %(_mid)s" %locals() )
print( "最大値は %(_max)s" %locals() )
print( "標準偏差は %(_sd)s" %locals() )

plt.plot(x, gaussian_func(x,para[0],para[1],para[2]), lw=3)
plt.show()
plt.savefig("image.png")

