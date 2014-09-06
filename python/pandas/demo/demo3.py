import numpy as np
import scipy as sp
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats

arr = sp.array([[435, 265],
                [165, 135]])
df = pd.DataFrame(arr)

x2, p, dof, expected = stats.chi2_contingency(df)
print(p)
