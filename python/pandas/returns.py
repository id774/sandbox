# -*- coding:utf-8 -*-

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import pandas.io.data as web

import matplotlib.dates as dates
from datetime import datetime

from matplotlib import font_manager

fontprop = font_manager.FontProperties(
    fname="/usr/share/fonts/truetype/fonts-japanese-gothic.ttf")

price = web.get_data_yahoo('AAPL', '2009-12-31')['Adj Close']

returns = price.pct_change()
ret_index = (1 + returns).cumprod()

ret_index[0] = 1
print(ret_index)
m_returns = ret_index.resample('BM', how='last').pct_change()

print(m_returns['2014'])

#data = web.get_data_yahoo('AAPL', '2011-03-01')
#px = data['Adj Close']
#returns = px.pct_change()
#returns = price.pct_change()

# def to_index(rets):
#    index = (1 + rets).cumprod()
#    first_loc = max(index.notnull().argmax() - 1, 0)
#    index.values[first_loc] = 1
#    return index
#
# def trend_signal(rets, lookback, lag):
#    signal = pd.rolling_sum(rets, lookback, min_periods=lookback - 5)
#    return signal.shift(lag)

#signal = trend_signal(returns, 100, 3)
#trade_friday = signal.resample('W-FRI'),resample('B', fill_method='ffill')
#trade_rets = trand_friday.shift(1) * returns

# to_index(trade_rets).plot()

def get_px(stock, start, end):
    return web.get_data_yahoo(stock, start, end)['Adj Close']

names = ['AAPL', 'GOOG', 'MSFT', 'DELL', 'GS', 'MS', 'BAC', 'C']
px = pd.DataFrame({n: get_px(n, '1/1/2010', '3/11/2014') for n in names})

px = px.asfreq('B').fillna(method='pad')
rets = px.pct_change()
result = ((1 + rets).cumprod() - 1)

plt.figure()
#ax = fig.add_subplot(1,1,1)
#
# notes = [
#    (datetime(2011,3,11), "東日本大震災")
#]
# for date, label in notes:
#    ax.annotate(label, xy=(date), xytext=(date), arrowprops=dict(facecolor='black'), horizontalalignment='left', verticalalignment='top')

result.plot()
plt.show()
plt.savefig("image.png")
