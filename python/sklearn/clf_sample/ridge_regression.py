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

s = pd.read_csv("sampledata.csv", index_col=0, parse_dates=True)
# Features
x, y = create_features(s['Values'], range=999)

from sklearn import linear_model
clf = linear_model.Ridge()

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

classify(clf, arr, -30, -16)
classify(clf, arr, -17, -3)
classify(clf, arr, -16, -2)
classify(clf, arr, -15, -1)
