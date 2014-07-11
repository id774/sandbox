from pylab import *
import numpy.random
import scipy.stats
import timeit
import matplotlib.pyplot as plt

def poisson_rand1(mu):
  th = e**(-mu) ## <1
  x = numpy.random.random()
  k = 0
  while x >= th:
    x *= numpy.random.random()
    k += 1
  return k

def poisson_rand2(mu):
  k = 0.0
  a = 1.0
  s = 0.0
  u = numpy.random.random() * e**mu
  while True:
    s += a
    if s > u:
      return k
    k += 1
    a = a * mu / k

N = 100000
mu = 6

s = []
t = []
time = []
time2 = []

s.append( [poisson_rand1(mu) for x in range(N)] )
t.append("poisson_rand1 (mu=%d)" % mu)
tm = timeit.Timer("poisson_rand1(%d)" % mu, "from __main__ import poisson_rand1")
time.append(tm.timeit(N))
time2.append(-1)

s.append( [poisson_rand2(mu) for x in range(N)] )
t.append("poisson_rand2 (mu=%d)" % mu)
tm = timeit.Timer("poisson_rand2(%d)" % mu, "from __main__ import poisson_rand2")
time.append(tm.timeit(N))
time2.append(-1)

s.append( numpy.random.poisson(mu, N) )
t.append("numpy.random.poisson(mu=%d)" % mu)
tm = timeit.Timer("numpy.random.poisson(%d)" % (mu), "import numpy.random")
time.append(tm.timeit(N))
tm = timeit.Timer("numpy.random.poisson(%d,%d)" % (mu,N), "import numpy.random")
time2.append(tm.timeit(1))

s.append( scipy.stats.poisson.rvs(mu, size=N) )
t.append("scipy.stats.poisson.rvs(mu=%d)" % mu)
tm = timeit.Timer("scipy.stats.poisson.rvs(%d)" % (mu), "import scipy.stats")
time.append(tm.timeit(N))
tm = timeit.Timer("scipy.stats.poisson.rvs(%d, size=%d)" % (mu,N), "import scipy.stats")
time2.append(tm.timeit(1))

for i in range(4):
  subplot(2,2,1+i)
  axis([0,20,0,0.18])
  count, bins, ignored = plt.hist(s[i], arange(21), normed=True)
  text(19, 0.16, "%3.3fmsec" % (time[i]*1000), color='gray', fontsize=12, horizontalalignment='right')
  if time2[i] > 0:
    text(19, 0.15, "%3.3fmsec" % (time2[i]*1000), color='gray', fontsize=12, horizontalalignment='right')
  title(t[i])

show()
plt.savefig("image.png")
