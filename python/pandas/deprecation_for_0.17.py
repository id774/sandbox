# deprecation_for_0.17.py: Reshape a linear regression input for scikit-learn 0.17
#
# Description:
# Fit a linear regression with the reshaped input scikit-learn 0.17 requires.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 deprecation_for_0.17.py
#
# Requirements:
# - Python 3
# - NumPy and scikit-learn
#

import sklearn.linear_model as linear_model
import numpy as np

X = np.array([10, 20, 30, 60, 108])
Y = np.array([11, 23, 43, 170.5, 934.6])
model = linear_model.LinearRegression()
X = X.reshape(-1, 1)
model.fit(X, Y)
print("Predict for number 12 {}".format(model.predict([12])[0]))
