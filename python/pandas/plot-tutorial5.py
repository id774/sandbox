#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Take log differences of macroeconomic series to make them stationary.

import numpy as np
from pandas import *
import matplotlib.pyplot as plt

macro = read_csv('macrodata.csv')

data = macro[['cpi', 'm1', 'tbilrate', 'unemp']]

# .diff() takes the difference from the previous row, NaN on the first
# .dropna() removes the NaN rows
trans_data = np.log(data).diff().dropna()

# Show the last 5 rows of trans_data
print(trans_data[-5:])

# Plot a scatter chart from two columns
plt.scatter(trans_data['m1'], trans_data['unemp'])

plt.show()
plt.savefig("image.png")

# Generate a scatter matrix over every column
scatter_matrix(trans_data, diagonal='kde', color='k', alpha=0.3)

plt.show()
plt.savefig("image2.png")
