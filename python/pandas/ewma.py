import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

ewma = pd.stats.moments.ewma

x = list(range(1, 50)) + list(range(50, 0, -1))
ma = ewma(np.array(x), span=15)

plt.plot(x, linewidth=1.0)
plt.plot(ma, linewidth=1.0)

plt.show()
plt.savefig("image.png")
