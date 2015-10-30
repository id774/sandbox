import pandas as pd
import numpy as np

def create_features(arr, range=3600):
    # if range > 3285:
    #     range = 3285
    range = range * -1
    train_X = []
    train_y = []
    for i in np.arange(range, -360):
        s = i + 360
        feature = arr.ix[i:s]
        x = feature.values
        y = arr[s]
        # print("train_X:", x)
        # print("train_y:", y)
        train_X.append(x)
        # train_y.append(y)
        if y <= 1:
            train_y.append(1)
        elif y >= 2 and y <= 8:
            train_y.append(2)
        else:
            train_y.append(3)
    return np.array(train_X), np.array(train_y)

df = pd.read_csv("jma_sample.csv", index_col=0, parse_dates=True)

division_point = 100
d = division_point * -1
train_df = df.ix[:d, :]
test_df = df.ix[d:, :]
s = 3600 - division_point
x, y = create_features(train_df['Value'], range=s)

# Save train data to CSV
pd.DataFrame(x).to_csv('x.csv')
pd.DataFrame(y).to_csv('y.csv')

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
    DecisionTreeClassifier(max_depth=360),
    RandomForestClassifier(
        max_depth=100, n_estimators=30, max_features=1),
    AdaBoostClassifier(),
    GaussianNB(), MultinomialNB(), BernoulliNB(),
    LDA()]
dic = dict(zip(names, classifiers))
clf = dic["Decision Tree"]
# clf = dic["Random Forest"]
# clf = dic["AdaBoost"]
# clf = dic["Gaussian Naive Bayes"]
# clf = dic["Multinomial Naive Bayes"]
# clf = dic["Bernoulli Naive Bayes"]
# clf = dic["LDA"]

# Fitting
clf.fit(x, y)

# ruler = 450
# s = ruler * -1
# e = s + 360
# samples = test_df['Value'].ix[s:e].values
# correct = test_df['Value'].ix[e]

for i in np.arange(361, len(train_df)):
    s = i * -1
    e = s + 360
    samples = train_df['Value'].ix[s:e].values
    correct = train_df['Value'].ix[e]
    # print(samples)
    print(correct)
    print(clf.predict(samples))
