import numpy as np
import matplotlib.pyplot as plt

x = np.arange(0, 10, 0.1)
y = np.cos(x)
plt.figure()
plt.plot(x, y, 'o')
plt.show()
plt.savefig("image.png")

x = np.arange(0, 5, 0.1)
y = np.sin(x)
plt.figure()
plt.plot(x, y, 'o')
plt.show()
plt.savefig("image2.png")
