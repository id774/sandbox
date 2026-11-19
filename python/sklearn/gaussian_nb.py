# -*- coding: utf-8 -*-
# gaussian_nb.py: Gaussian naive Bayes on a small integer matrix
#
# Description:
# Fit a Gaussian naive Bayes classifier to a small integer matrix.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 gaussian_nb.py
#
# Requirements:
# - Python 3
# - NumPy and scikit-learn
#

import numpy as np
from sklearn.naive_bayes import GaussianNB

X = np.array([[1, 2, 3, 4, 5, 6, 7, 8],
              [1, 1, 3, 4, 5, 6, 6, 7],
              [2, 1, 2, 4, 5, 8, 8, 8]])
y = np.array([1, 2, 3])

print(X)

clf = GaussianNB()
clf.fit(X, y)

_t = np.array([2, 2, 4, 5, 6, 8, 8, 8])

print(_t)

_result = clf.predict(_t)

print(_result)
