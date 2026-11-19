# nearest_neighbors_classifier.py: k-nearest neighbors classification of a point
#
# Description:
# Classify a point with k-nearest neighbours.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 nearest_neighbors_classifier.py
#
# Requirements:
# - Python 3
# - NumPy and scikit-learn
#

from sklearn.neighbors import KNeighborsClassifier
import numpy as np
X = np.array([[-1, -1], [-2, -1], [-3, -2], [1, 1], [2, 1], [3, 2]])
y = np.array([1, 1, 1, 2, 2, 2])
clf = KNeighborsClassifier()
clf.fit(X, y)
print(clf.predict([[-0.8, -1]]))
