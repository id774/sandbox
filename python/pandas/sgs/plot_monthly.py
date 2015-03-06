
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# 各月のデータを読み出す
df201411 = pd.read_csv("201411.csv", index_col=0)
df201412 = pd.read_csv("201412.csv", index_col=0)
df201501 = pd.read_csv("201501.csv", index_col=0)
df201502 = pd.read_csv("201502.csv", index_col=0)

# 上位報酬の行をシリーズに抽出する
s201411 = df201411.ix[700, :]
s201412 = df201412.ix[800, :]
s201501 = df201501.ix[1000, :]
s201502 = df201502.ix[1000, :]

# 簡単のためインデックスを数字に
s201411.index = np.arange(1, len(s201411) + 1)
s201412.index = np.arange(1, len(s201412) + 1)
s201501.index = np.arange(1, len(s201501) + 1)
s201502.index = np.arange(1, len(s201502) + 1)

# 各月のシリーズを連結してデータフレーム化する
df = pd.concat([s201411, s201412, s201501, s201502], axis=1)

# カラムも数字にする
df.columns = [11, 12, 1, 2]

# 可視化する
plt.figure()
df.plot()
plt.savefig('image.png')
plt.close()

pct_change = df.T.pct_change()

def estimated_from_reference(day):
    return df.ix[7, 1] * (1 + df.T.pct_change().ix[2, day])
estimated = [estimated_from_reference(x) for x in range(1, 7)]

print(estimated)

def estimated_from_perchange(criteria, day):
    return df.ix[criteria, 2] * (1 + df.pct_change().ix[day, 1])

print(df)
df.ix[5, 3] = estimated_from_perchange(4, 5)
df.ix[6, 3] = estimated_from_perchange(5, 6)
df.ix[7, 3] = estimated_from_perchange(6, 7)
print(df)
