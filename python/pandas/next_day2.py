import pandas as pd

s = pd.read_csv(
    "sampledata.csv",
    index_col=0, parse_dates=True)
print(s.index[-1])
index = pd.date_range(start=s.index[-1],
                      periods=2, freq='B')
ts = pd.Series(None, index=index)
print(ts.index[1])
