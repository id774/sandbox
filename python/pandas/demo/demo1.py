# demo1.py: Describe, box plot, and regress CSV columns
#
# Description:
# Describe data.csv from the current directory, draw a box plot saved as
# image.png, and regress two of its columns.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 demo1.py
#
# Requirements:
# - Python 3
# - SciPy and Matplotlib
# - pandas before 1.0, which still provides pandas.tools
# - data.csv in the current directory
#

import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats
from pandas.tools.plotting import scatter_matrix

df = pd.read_csv('data.csv', names=['X', 'Y', 'Z'])
plt.figure()
print(df.describe())
df.boxplot()
plt.savefig('image.png')

print(stats.linregress(df['X'], df['Z']))
