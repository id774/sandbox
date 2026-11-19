# scaling.py: Standardize a feature matrix
#
# Description:
# Standardize a feature matrix with preprocessing.scale.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 scaling.py
#
# Requirements:
# - Python 3
# - NumPy and scikit-learn
#

from sklearn import preprocessing
import numpy as np

X = np.array([[1., -1., 2.],
              [2., 0., 0.],
              [0., 1., -1.]])

X_scaled = preprocessing.scale(X)

print(X_scaled)
