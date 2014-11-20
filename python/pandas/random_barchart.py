import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

plt.figure()

data = pd.Series(np.random.randn(16), index=list('abcdefghijklmnop'))
print(data)
data.plot(kind='bar', color='k', alpha=0.7)

plt.show()
plt.savefig("image3.png")
