from pylab import *
import matplotlib.pyplot as plt

X = np.linspace(-np.pi, np.pi, 256,endpoint=True)
C,S = np.cos(X), np.sin(X)

plt.plot(X,C)
plt.plot(X,S)
plt.show()
plt.savefig("image.png")
