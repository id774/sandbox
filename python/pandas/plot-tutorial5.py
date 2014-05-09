#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
from pandas import *
import matplotlib.pyplot as plt

macro = read_csv('macrodata.csv')

data = macro[['cpi', 'm1', 'tbilrate', 'unemp']]

# .diff() は前の行からの差分、先頭の場合は NaN
# .dropna() は NaN なデータを削除
trans_data = np.log(data).diff().dropna()

# trans_data の最後の 5 行を表示
print( trans_data[-5:] )

# 2 つの列から散布図をプロッティング
plt.scatter(trans_data['m1'], trans_data['unemp'])

plt.show()
plt.savefig("image.png")

# 全列の散布図を生成
scatter_matrix(trans_data, diagonal='kde', color='k', alpha=0.3)

plt.show()
plt.savefig("image2.png")

