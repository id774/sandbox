import pandas as pd
import numpy as np

def create_features(arr, range=16):
    if range > 135:
        range = 135
    range = range * -1
    train_X = []
    train_y = []
    for i in np.arange(range, -14):
        s = i + 14
        feature = arr.ix[i:s]
        x = feature.values
        y = arr[s]
        print("Pointer:", i, s)
        print("X:", x)
        print("Y:", y)
        train_X.append(x)
        train_y.append(y)
    return np.array(train_X), np.array(train_y)

def create_features2(arr, range=16):
    if range > 135:
        range = 135
    range = range * -1
    train_X = []
    train_y = []
    for i in np.arange(range, -15):
        s = i + 14
        feature = arr.ix[i:s]
        x = feature.values
        s = s + 1
        y = arr[s]
        print("Pointer:", i, s)
        print("X:", x)
        print("Y:", y)
        train_X.append(x)
        train_y.append(y)
    return np.array(train_X), np.array(train_y)

s = pd.read_csv("sampledata.csv", index_col=0, parse_dates=True)
# Features
x, y = create_features(s['Values'], range=999)

from sklearn import linear_model
clf = linear_model.Ridge(alpha=7)
# clf = linear_model.Lasso(alpha=2)

# Fitting
print("Trained")
print(x)
print(y)
clf.fit(x, y)

# Classify
print("Predict")
arr = s['Values']

def classify(clf, arr, a, b):
    t = arr.values[a:b]
    print(t)
    print(clf.predict(t))

print("test1")
classify(clf, arr, -30, -16)
classify(clf, arr, -17, -3)
classify(clf, arr, -16, -2)
classify(clf, arr, -15, -1)

t = [1.0, 1.2, 1.1, 1.3, 1.4, 1.5, 1.1, 1.2, 1.3, 1.1, 1.0, 1.1, 1.2, 1.1]
print(t)
print(clf.predict(t))

t = [2.0, 2.2, 2.1, 2.0, 2.4, 2.5, 2.1, 2.2, 2.3, 2.4, 2.8, 2.5, 2.7, 2.9]
print(t)
print(clf.predict(t))

t = [1.0, 1.8, 1.1, 2.0, 2.4, 2.5, 2.1, 2.2, 2.3, 2.4, 2.8, 2.5, 2.7, 2.9]
print(t)
print(clf.predict(t))

t = [5008.1, 5012.2, 5055.3, 5140.0, 5099.0,
     5093.0, 5071.0, 5013.4, 5055.1, 5000.0,
     5022.0, 5013.0, 5081.1, 5088.1]
print(t)
print(clf.predict(t))

x, y = create_features2(s['Values'], range=999)
print("Trained")
print(x)
print(y)
clf.fit(x, y)

print("test2")
classify(clf, arr, -30, -16)
