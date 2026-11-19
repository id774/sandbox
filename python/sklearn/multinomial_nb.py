# multinomial_nb.py: Multinomial naive Bayes on random counts
#
# Description:
# Fit a multinomial naive Bayes classifier to random count data.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 multinomial_nb.py
#
# Requirements:
# - Python 3
# - NumPy and scikit-learn
#

import numpy as np
X = np.random.randint(5, size=(6, 100))
y = np.array([1, 2, 3, 4, 5, 6])
from sklearn.naive_bayes import MultinomialNB
clf = MultinomialNB()
clf.fit(X, y)
MultinomialNB(alpha=1.0, class_prior=None, fit_prior=True)

_t = np.array([0, 0, 1, 1, 3, 1, 4, 0, 1, 1, 4, 3, 0, 3, 4, 3, 1, 3, 1, 4, 0, 4, 4, 4, 0, 0, 4, 1, 4, 4, 1, 3, 0, 3, 0, 2, 4,
               1, 1, 0, 0, 2, 2, 0, 2, 4, 3, 4, 0, 4, 4, 3, 0, 0, 2, 1, 4, 1, 4, 4, 3, 3, 1, 2, 3, 4, 0, 3, 3, 4, 1, 3, 4, 0,
               0, 0, 3, 4, 2, 0, 0, 4, 3, 0, 4, 3, 1, 2, 0, 1, 3, 1, 0, 3, 1, 1, 0, 1, 3, 1])

print(X)
print(clf.predict(X[0]))
print(clf.predict(X[1]))
print(clf.predict(X[2]))
print(clf.predict(X[3]))
print(clf.predict(X[4]))
print(clf.predict(X[5]))
print(_t)
print(clf.predict(_t))
