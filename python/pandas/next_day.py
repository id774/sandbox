import pandas as pd
import datetime

s = pd.read_csv(
    "sampledata.csv",
    index_col=0, parse_dates=True)
print(s.index[-1])
period_day = s.index[-1] + datetime.timedelta(days=1)
index = pd.date_range(start=period_day,
                      periods=1, freq='B')
ts = pd.Series(None, index=index)
print(ts.index[0])
