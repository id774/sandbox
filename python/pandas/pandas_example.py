import pandas as pd
import numpy as np

dates = pd.date_range("20130101", periods=6)
print(dates)
df = pd.DataFrame(np.random.randn(6,4),index=dates,columns=list('ABCD'))
print(df)
df2 = pd.DataFrame({ 'A' : 1.,
                     'B' : pd.Timestamp('20130102'),
                     'C' : pd.Series(1,index=list(range(4)),dtype='float32'),
                     'D' : np.array([3] * 4,dtype='int32'),
                     'E' : pd.Categorical(["test","train","test","train"]),
                     'F' : 'foo' })
print(df2)
print(df2.dtypes)
print(df.index)
print(df.columns)
print(df.values)
print(df.describe())
print(df.T)
result = df.sort_index(axis=1, ascending=False)
print(result)
result = df.sort(columns='B')
print(result)
result = df.loc['20130102':'20130104',['A','B']]
print(result)
df = pd.DataFrame({"A" : ['foo', 'bar', 'foo', 'bar','foo', 'bar', 'foo', 'foo'],
                   "B" : ['one', 'one', 'two', 'three','two', 'two', 'one', 'three'],
                   "C" : np.random.randn(8),
                   "D" : np.random.randn(8)})
print(df)
result = df.sort(columns='B')
print(result)
result = df.groupby('A').sum()
print(result)
df = pd.DataFrame({'A' : ['one', 'one', 'two', 'three'] * 3,
                   'B' : ['A', 'B', 'C'] * 4,
                   'C' : ['foo', 'foo', 'foo', 'bar', 'bar', 'bar'] *2,
                   'D' : np.random.randn(12),
                   'E' : np.random.randn(12)})
print(df)
result = pd.pivot_table(df, values='D', index=['A', 'B'], columns=['C'])
print(result)
