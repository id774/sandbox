#!/usr/bin/env python
# - * - coding: utf-8 - * -

# http://d.hatena.ne.jp/dichika/20120819/1345385529
# http://pandas.pydata.org/pandas-docs/stable/

import pandas as pd
import matplotlib.pyplot as plt
from pandas import DataFrame
import xlrd  # needed to read xls files
import numpy as np
import sqlite3

# Build a data frame
smp = {'state': ['Ohio', 'Ohio', 'Ohio', 'Nebada', 'Nebada'],
       'year': [2000, 2001, 2002, 2001, 2002],
       'pop': [1.5, 1.6, 1.7, 3.5, 4.3]
       }
frame = DataFrame(smp)

# Access the elements of a data frame
frame.year  # frame$year
frame['year']  # frame$year
frame.head()  # head
frame.tail()  # tail
frame2 = DataFrame(
    smp, index=['one', 'two', 'three', 'four', 'five'])  # add an index
frame2.ix['one']
frame2.describe()  # summary
print(frame2.describe())

# Read data in
data = pd.read_csv('stock_px.csv')
print(data)
xlsx_file = pd.ExcelFile('stock_px.xlsx')  # openpyxl must be installed; xls also works
xlsx_file.sheet_names
data = xlsx_file.parse('stock_px')
print(data)

# Read data from the web: http://docs.scipy.org/doc/numpy/reference/generated/numpy.DataSource.html
ds = np.DataSource(None)
f = ds.open('https://dl.dropbox.com/u/956851/game_modified.csv')
d_web = pd.read_csv(f)
print(d_web)
f.close()

# Pivot table
data2 = DataFrame(data[:100], columns=['cut', 'clarity', 'price', 'color'])
pd.pivot_table(
    data2, values='price', rows=['clarity', 'cut'], cols=['color'], aggfunc='sum')

# Merge
data.l = DataFrame(data[:6], columns=['carat', 'clarity', 'price', 'depth'])
data.r = DataFrame(data[-6:], columns=['carat', 'clarity', 'price', 'depth'])
pd.merge(data.l, data.r, on='clarity')
pd.merge(data.l, data.r, on='clarity', how='outer')
pd.merge(data.l, data.r, on='clarity', how='left')
pd.merge(data.l, data.r, on='clarity', how='right')

# Concatenate
print(pd.concat([data.l, data.r]))  # rbind

# Sort
data2.sort_index(by=['clarity'])
data2.sort_index(by=['clarity'], ascending=False)

# groupby
data4 = DataFrame(
    data[:100], columns=['cut', 'color', 'clarity', 'carat', 'price'])
data4.groupby('clarity').mean()  # only numeric columns are aggregated
data4.groupby(['cut', 'clarity']).mean()  # with two or more levels
data4.groupby(['cut', 'clarity']).mean()['price']  # accessing the result

# apply
data5 = DataFrame(data[:6], columns=['carat', 'price', 'depth'])
f = lambda x: x.max() - x.min()
data5.apply(f)
data5.apply(f, axis=1)  # along rows; the default is along columns
f2 = lambda x: '%.2f' % x  # format numbers to two decimal places
data5.applymap(f2)  # apply to every element of the data frame

# vlookup
clarity_to_class = {
    'SI1': 'A', 'SI2': 'B', 'VS1': 'C', 'VS2': 'D', 'VVS2': 'E'}
data2['class'] = data2['clarity'].map(clarity_to_class)

# DB: SELECT statement
#import pandas.io.sql as sql
#con = sqlite3.connect(':memory:')
#sql.read_frame('select * from test', con)

# Write data out as CSV
data.to_csv('output.csv')

# Write data out as Excel
writer = pd.ExcelWriter('output.xlsx')
#data2.to_excel(writer, sheet_name='sample')
# writer.save()

# Draw with matplotlib
data.plot()
plt.show()
plt.savefig("image.png")
