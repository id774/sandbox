import numpy as np
from collections import Counter
import matplotlib.pyplot as plt

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)

M = 1000
for N in [10, 30, 50, 100]:
    data = [np.average(np.random.poisson(3, N)) for i in range(M)]
    hist, key = np.histogram(data, bins=np.arange(1, 5, 0.1), density=True)
    ax.plot(hist, label=str(N))
    for i in range(len(hist)):
        print("{0}\t{1}".format(key[i], hist[i]))
    print("\n")

plt.legend(loc='best')
plt.show()
plt.savefig("image.png")
