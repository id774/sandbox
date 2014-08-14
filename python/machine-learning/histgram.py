# -*- coding:utf-8 -*-

import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import numpy as np

sample = 1000
mu, sigma = 170, 5
data = np.random.normal(mu, sigma, sample)

print("出力するデータは %(data)s" % locals())

n, bins, patches = plt.hist(data, normed=1, alpha=0.75, align='mid')
y = mlab.normpdf(bins, mu, sigma)
l = plt.plot(bins, y, 'r-', linewidth=1)

plt.title(
    r'$\mathrm{Histgram\ of\ Height:}\ \mu=%d,\ \sigma=%d$' % (mu, sigma))
plt.xlabel('Height')
plt.ylabel('Probability')
plt.grid(True)

plt.show()
plt.savefig("image.png")
