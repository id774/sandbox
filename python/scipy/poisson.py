from pylab import *
import scipy.misc

def poisson_pmf_gen(mu):
  e_mu = e ** mu
  return lambda x:mu**x / (e_mu * scipy.misc.factorial(x))

for mu in arange(1, 11):
  pmf = poisson_pmf_gen(mu)

  axis([0,15, 0,pmf(mu)+0.05])
  xlabel('x')
  ylabel('p(x)')
  title("Poisson distribution (mu = %d)" % mu)

  x = arange(0,15)
  bar(x, pmf(x), 0.8, color="gray")

  savefig("poisson_naive_%02d" % mu)
  clf()
