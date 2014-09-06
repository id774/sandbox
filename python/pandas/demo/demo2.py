import numpy as np
import scipy as sp
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats

X = [68, 75, 80, 71, 73, 79, 69, 65]
Y = [86, 83, 76, 81, 75, 82, 87, 75]

df = pd.DataFrame({'X': X, 'Y': Y})

plt.figure()
plt.scatter(X, Y)

print(df.corr())
print(stats.ttest_rel(X, Y))
