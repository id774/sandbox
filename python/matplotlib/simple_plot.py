import matplotlib.pyplot as plt
from numpy.random import randn

x1 = randn(50).cumsum()
x2 = randn(50).cumsum()
x3 = randn(50).cumsum()
x4 = randn(50).cumsum()

plt.figure()
plt.plot(x1, 'k--')
plt.plot(x2, 'r--')
plt.plot(x3, 'g--')
plt.plot(x4, 'b--')

plt.savefig('image.png')
