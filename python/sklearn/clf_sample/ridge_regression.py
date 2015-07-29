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
        train_y.append(feature[-1])
        train_X.append(feature.values)
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
print(x[-1:])
print(clf.predict(x[-1:]))
