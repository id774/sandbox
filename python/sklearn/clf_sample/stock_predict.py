import datetime
import numpy as np
import pandas as pd

s = pd.read_csv("sampledata.csv", index_col=0, parse_dates=True)
period_day = s.index[-1] + datetime.timedelta(days=1)
index = pd.date_range(start=period_day,
                      periods=180, freq='B')
dup_ts = pd.Series(None, index=index)
t = pd.concat([s, dup_ts])

def features(arr, range=16):
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
        train_X.append(x)
        train_y.append(y)
    return np.array(train_X), np.array(train_y)

x, y = features(s['Values'], range=999)

from sklearn import linear_model
clf = linear_model.Ridge(alpha=0.5)
clf.fit(x, y)

for i in np.arange(0, 180):
    _from = i + 166
    _to = i + 180
    arr = np.array(t.ix[_from:_to]['Values'].values)
    print(arr)
    ans = clf.predict(arr)[0]
    print(ans)
    t['Values'][_to] = ans

print(len(t))
t['Close'] = t['Values'] * 16780.53
t.to_csv('expand_ts.csv')
