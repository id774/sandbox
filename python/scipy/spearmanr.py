import numpy as np
from scipy.stats import spearmanr

xint = np.random.randint(10, size=(100, 2))
print(spearmanr(xint))
