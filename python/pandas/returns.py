# -*- coding:utf-8 -*-

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import pandas.io.data as web

import matplotlib.dates as dates
from datetime import datetime

from matplotlib import font_manager

fontprop = font_manager.FontProperties(fname="/usr/share/fonts/truetype/fonts-japanese-gothic.ttf")

price = web.get_data_yahoo('AAPL', '2010-01-01')['Adj Close']

returns = price.pct_change()
ret_index = (1 + returns).cumprod()

ret_index[0] = 1
m_returns = ret_index.resample('BM', how='last').pct_change()

print( m_returns )

def get_px(stock, start, end):
    return web.get_data_yahoo(stock, start, end)['Adj Close']

names = ['AAPL', 'GOOG', 'MSFT', 'DELL', 'GS', 'MS', 'BAC', 'C']
px = pd.DataFrame( {n: get_px(n, '1/1/2010', '3/1/2014') for n in names} )

px = px.asfreq('B').fillna(method='pad')
rets = px.pct_change()
result = ((1 + rets).cumprod() - 1)

plt.figure()
result.plot()
plt.show()
plt.savefig("image.png")

