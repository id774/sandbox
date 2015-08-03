import pandas as pd
import datetime

s = pd.read_csv("../sklearn/clf_sample/sampledata.csv", index_col=0, parse_dates=True)
period_day = s.index[-1] + datetime.timedelta(days=1)
index = pd.date_range(start=period_day,
                      periods=180, freq='B')
dup_ts = pd.Series(None, index=index)
t = pd.concat([s, dup_ts])

print(len(s))
print(len(dup_ts))
print(len(t))
t['Close'] = t['Values'] * 16780.53
t.to_csv('expand_ts.csv')
