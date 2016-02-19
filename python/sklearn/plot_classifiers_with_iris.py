"""
==================================================
Plot the decision boundaries of a VotingClassifier
==================================================

Plot the decision boundaries of a `VotingClassifier` for
two features of the Iris dataset.

Plot the class probabilities of the first sample in a toy dataset
predicted by three different classifiers and averaged by the
`VotingClassifier`.

First, three examplary classifiers are initialized (`DecisionTreeClassifier`,
`KNeighborsClassifier`, and `SVC`) and used to initialize a
soft-voting `VotingClassifier` with weights `[2, 1, 2]`, which means that
the predicted probabilities of the `DecisionTreeClassifier` and `SVC`
count 5 times as much as the weights of the `KNeighborsClassifier` classifier
when the averaged probability is calculated.

"""
print(__doc__)

import numpy as np
import matplotlib.pyplot as plt
from itertools import product

from sklearn import datasets
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.svm import LinearSVC
from sklearn.ensemble import AdaBoostClassifier
from sklearn.ensemble import ExtraTreesClassifier
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.lda import LDA

# Loading some example data
iris = datasets.load_iris()
X = iris.data[:, [0, 2]]
y = iris.target

# Training classifiers
clf1 = DecisionTreeClassifier(max_depth=4)
clf2 = KNeighborsClassifier(n_neighbors=7)
clf3 = SVC(kernel='rbf', probability=True)
clf4 = LinearSVC()
clf5 = AdaBoostClassifier()
clf6 = ExtraTreesClassifier()
clf7 = GradientBoostingClassifier()
clf8 = RandomForestClassifier(max_depth=5,
                              n_estimators=10,
                              max_features=1)
clf9 = GaussianNB()
clf10 = LDA()

clf1.fit(X, y)
clf2.fit(X, y)
clf3.fit(X, y)
clf4.fit(X, y)
clf5.fit(X, y)
clf6.fit(X, y)
clf7.fit(X, y)
clf8.fit(X, y)
clf9.fit(X, y)
clf10.fit(X, y)

# Plotting decision regions
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
xx, yy = np.meshgrid(np.arange(x_min, x_max, 0.1),
                     np.arange(y_min, y_max, 0.1))

f, axarr = plt.subplots(5, 2, sharex='col', sharey='row', figsize=(10, 20))

for idx, clf, tt in zip(product([0, 1, 2, 3, 4], [0, 1]),
                        [clf1, clf2, clf3, clf4, clf5,
                         clf6, clf7, clf8, clf9, clf10],
                        ['Decision Tree (depth=4)', 'KNN (k=7)',
                         'Kernel SVM', 'Linear SVC',
                         'AdaBoost', 'Extra Trees',
                         'Gradient Boosting',
                         'Random Forest (depth=5, estimators=10)',
                         'Gaussian NB', 'LDA']):

    Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)

    axarr[idx[0], idx[1]].contourf(xx, yy, Z, alpha=0.4)
    axarr[idx[0], idx[1]].scatter(X[:, 0], X[:, 1], c=y, alpha=0.8)
    axarr[idx[0], idx[1]].set_title(tt)

plt.show()
plt.savefig('image.png')
