# corrs_heatmap.py: Heatmap of digit data set feature correlations
#
# Description:
# Draw a heatmap of the correlations between digit data set features.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 corrs_heatmap.py
#
# Requirements:
# - Python 3
# - NumPy, pandas, scikit-learn, and Matplotlib
#

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn import datasets

digits = datasets.load_digits()
df = pd.DataFrame(digits.data)
corrs = df.corr()

def draw_heatmap(corrs):
    plt.figure()
    plt.pcolor(corrs, cmap='bwr', vmin=-1.0, vmax=1.0)
    plt.yticks(np.arange(0.5, len(corrs.index), 1), corrs.index)
    plt.xticks(np.arange(0.5, len(corrs.columns), 1), corrs.columns)
    plt.colorbar()
    plt.savefig('image.png')
    plt.close()

draw_heatmap(corrs)
