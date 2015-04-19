from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from sklearn.naive_bayes import GaussianNB, MultinomialNB, BernoulliNB
from sklearn.lda import LDA
import sys
import numpy as np

def new_clf(classifier="Decision Tree"):
    names = ["Decision Tree",
             "Random Forest", "AdaBoost",
             "Gaussian Naive Bayes",
             "Multinomial Naive Bayes",
             "Bernoulli Naive Bayes",
             "LDA"]
    print(names)
    print(classifier)
    classifiers = [
        DecisionTreeClassifier(max_depth=5),
        RandomForestClassifier(
            max_depth=5, n_estimators=10, max_features=1),
        AdaBoostClassifier(),
        GaussianNB(), MultinomialNB(), BernoulliNB(),
        LDA()]
    dic = dict(zip(names, classifiers))
    return dic[classifier]

X = np.array([[-1, -1], [-2, -1], [-3, -2], [1, 1], [2, 1], [3, 2]])
y = np.array([1, 1, 1, 2, 2, 2])
clf = new_clf(classifier=sys.argv[1])
clf.fit(X, y)
print(clf.predict([[-0.8, -1]]))
