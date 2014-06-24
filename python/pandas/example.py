#!/usr/bin/env python
# - * - coding: utf-8 - * -

# http://d.hatena.ne.jp/dichika/20120819/1345385529
# http://pandas.pydata.org/pandas-docs/stable/

import pandas as pd
import matplotlib.pyplot as plt
from pandas import DataFrame
import xlrd # xlsを読み込む際に必要
import numpy as np
import sqlite3

# データフレームを作る
smp = {'state' : ['Ohio', 'Ohio', 'Ohio', 'Nebada', 'Nebada'],
       'year' : [2000, 2001, 2002, 2001, 2002],
       'pop' : [1.5, 1.6, 1.7, 3.5, 4.3]
       }
frame = DataFrame(smp)

# データフレームの要素へのアクセス
frame.year # frame$year
frame['year'] # frame$year
frame.head() # head
frame.tail() # tail
frame2 = DataFrame(smp, index = ['one', 'two', 'three', 'four', 'five']) # インデックスを追加
frame2.ix['one']
frame2.describe() # summary
print( frame2.describe() )

# データを読み込む
data = pd.read_csv('stock_px.csv')
print( data )
xlsx_file = pd.ExcelFile('stock_px.xlsx') # openpyxlのインストールが必要, xlsも可
xlsx_file.sheet_names
data = xlsx_file.parse('stock_px')
print( data )

# web上のデータを読み込む→http://docs.scipy.org/doc/numpy/reference/generated/numpy.DataSource.html
ds = np.DataSource(None)
f = ds.open('https://dl.dropbox.com/u/956851/game_modified.csv')
d_web = pd.read_csv(f)
print( d_web )
f.close()

# ピボットテーブル
data2 = DataFrame(data[:100], columns = ['cut', 'clarity', 'price', 'color'])
pd.pivot_table(data2, values = 'price', rows = ['clarity', 'cut'], cols = ['color'], aggfunc = 'sum')

# マージ
data.l = DataFrame(data[:6], columns = ['carat', 'clarity', 'price', 'depth'])
data.r = DataFrame(data[-6:], columns = ['carat', 'clarity', 'price', 'depth'])
pd.merge(data.l, data.r, on = 'clarity')
pd.merge(data.l, data.r, on = 'clarity', how = 'outer')
pd.merge(data.l, data.r, on = 'clarity', how = 'left')
pd.merge(data.l, data.r, on = 'clarity', how = 'right')

# 結合
print( pd.concat([data.l, data.r]) ) # rbind

# ソート
data2.sort_index(by = ['clarity'])
data2.sort_index(by = ['clarity'], ascending = False)

# groupby
data4 = DataFrame(data[:100], columns = ['cut', 'color', 'clarity', 'carat', 'price'])
data4.groupby('clarity').mean() # 数値のものだけ集計される
data4.groupby(['cut', 'clarity']).mean() # 2水準以上の場合
data4.groupby(['cut', 'clarity']).mean()['price'] # 結果に対してのアクセス

# apply
data5 = DataFrame(data[:6], columns = ['carat', 'price', 'depth'])
f = lambda x: x.max() - x.min()
data5.apply(f)
data5.apply(f, axis = 1) # 行方向(デフォルトは列方向)
f2 = lambda x: '%.2f' % x # 数値の書式を下2桁表示に変更
data5.applymap(f2) # データフレームの各要素に適用

# vlookup
clarity_to_class = {'SI1' : 'A', 'SI2' : 'B', 'VS1' : 'C', 'VS2' : 'D', 'VVS2' : 'E'}
data2['class'] = data2['clarity'].map(clarity_to_class)

# DB:SELECT文
#import pandas.io.sql as sql
#con = sqlite3.connect(':memory:')
#sql.read_frame('select * from test', con)

# データを書き出す-csv
data.to_csv('output.csv')

# データを書き出す-エクセル
writer = pd.ExcelWriter('output.xlsx')
#data2.to_excel(writer, sheet_name='sample')
#writer.save()

# matplotlibによる描画
data.plot()
plt.show()
plt.savefig("image.png")

