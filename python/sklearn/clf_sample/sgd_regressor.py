# sgd_regressor.py: Stochastic gradient regression on sliding window features
#
# Description:
# Predict a series from sliding window features with a stochastic gradient
# regressor, reading sampledata.csv from the current directory.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 sgd_regressor.py
#
# Requirements:
# - Python 3
# - NumPy and scikit-learn
# - pandas before 1.0, which still provides DataFrame.ix
# - sampledata.csv in the current directory
#

import pandas as pd
import numpy as np

def create_features(arr, range=16):
    if range > 135:
        range = 135
    range = range * -1
    train_X = []
    train_y = []
    for i in np.arange(range, -15):
        s = i + 14
        feature = arr.ix[i:s]
        train_y.append(feature[-1])
        print(feature[-1])
        train_X.append(feature.values)
        print(feature.values)
    return np.array(train_X), np.array(train_y)

s = pd.read_csv("sampledata.csv", index_col=0, parse_dates=True)
# Features
x, y = create_features(s['Values'])

from sklearn import linear_model
clf = linear_model.SGDRegressor()

# Fitting
clf.fit(x, y)

# Classify
print(x)
print(clf.predict(x))
