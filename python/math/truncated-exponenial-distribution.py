import numpy as np
import matplotlib.pyplot as plt
from scipy import integrate

def g(x):
    return 0 if x < 4.5 else np.exp(-(x - 4.5))

ix = np.arange(-5, 30, 0.01)
iy = [g(x) for x in ix]

plt.plot(ix, iy, label="g(x)")
plt.legend(loc="best")
plt.show()
plt.savefig("image.png")

print(integrate.quad(g, -np.inf, np.inf)[0])
