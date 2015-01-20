import numpy as np
import pandas as pd

df = pd.DataFrame({'key1' : ['a', 'a', 'b', 'b', 'a'],
'key2' : ['one', 'two', 'one', 'two', 'one'],
'data1' : np.random.randn(5),
'data2' : np.random.randn(5)})
print(df)

grouped = df['data1'].groupby(df['key1'])
print(df['key1'])
print(grouped)
print(grouped.mean())
print(grouped.sum())

means = df['data1'].groupby([df['key1'], df['key2']]).mean()
print(means)
print(means.unstack())

states = np.array(['Ohio', 'California', 'California', 'Ohio', 'Ohio'])
print(states)
years = np.array([2005,2005,2006,2005,2006])
print(years)
r = df['data1'].groupby([states, years]).mean()
print(r)

print(df.groupby(['key1', 'key2']).mean())
print(df.groupby(['key1', 'key2']).size())
print(df.groupby(['key1']).size())
for name, group in df.groupby('key1'):
    print(name)
    print(group)

pieces = dict(list(df.groupby('key1')))
print(pieces)
