# nearest_centroid_classifier.py: Nearest centroid classification of a point
#
# Description:
# Classify a point with the nearest centroid rule.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 nearest_centroid_classifier.py
#
# Requirements:
# - Python 3
# - NumPy
# - scikit-learn before 0.24, which still provides
#   sklearn.neighbors.nearest_centroid
#

from sklearn.neighbors.nearest_centroid import NearestCentroid
import numpy as np
X = np.array([[-1, -1], [-2, -1], [-3, -2], [1, 1], [2, 1], [3, 2]])
y = np.array([1, 1, 1, 2, 2, 2])
clf = NearestCentroid()
clf.fit(X, y)
print(clf.predict([[-0.8, -1]]))
