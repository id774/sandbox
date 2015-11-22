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
        if feature[-1] < arr[s]:
            train_y.append(1)
        else:
            train_y.append(0.)
        train_X.append(feature.values)
    return np.array(train_X), np.array(train_y)

s = pd.read_csv("sampledata.csv", index_col=0, parse_dates=True)
# Features
x, y = create_features(s['Values'], range=32)

from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from sklearn.naive_bayes import GaussianNB, MultinomialNB, BernoulliNB
from sklearn.lda import LDA

names = ["Decision Tree",
         "Random Forest", "AdaBoost",
         "Gaussian Naive Bayes",
         "Multinomial Naive Bayes",
         "Bernoulli Naive Bayes",
         "LDA"]
classifiers = [
    DecisionTreeClassifier(max_depth=5),
    RandomForestClassifier(
        max_depth=5, n_estimators=10, max_features=1),
    AdaBoostClassifier(),
    GaussianNB(), MultinomialNB(), BernoulliNB(),
    LDA()]
dic = dict(zip(names, classifiers))
clf = dic["Gaussian Naive Bayes"]

# Fitting
print(x)
print(y)
print(len(x))
print(len(y))
clf.fit(x, y)

# Classify
print(clf.predict(x))
