# -*- coding:utf-8 -*-

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import pandas.io.data as web
import matplotlib.dates as dates
from datetime import datetime

from matplotlib import font_manager

fontprop = font_manager.FontProperties(fname="/usr/share/fonts/truetype/fonts-japanese-gothic.ttf")

px = web.get_data_yahoo('SPY')['Adj Close'] * 10
expiries = {
    'GCJ14': datetime(2014,4,28),
    'GCM14': datetime(2014,6,26)
}
expiry = pd.Series(expiries).order()

print( px.tail(5) )
print( expiry )

def random_walk(px):
    np.random.seed(34567)
    N = 200
    _walk = (np.random.randint(0, 200, size=N) - 100) * 0.25
    perturb = (np.random.randint(0, 20, size=N) - 10) * 0.25
    walk = _walk.cumsum()
    rng = pd.date_range(px.index[0], periods=len(px) + N, freq='B')
    near = np.concatenate([px.values, px.values[-1] + walk])
    far = np.concatenate([px.values, px.values[-1] + walk + perturb])
    prices = pd.DataFrame({'GCJ14': near, 'GCM14': far}, index=rng)
    return prices

prices = random_walk(px)
print( prices.tail(5) )

def get_roll_weights(start, expiry, items, roll_periods=5):
    dates = pd.date_range(start, expiry[-1], freq='B')
    weights = pd.DataFrame(np.zeros((len(dates), len(items))),
                        index=dates, columns=items)
    prev_date = weights.index[0]
    for i, (item, ex_date) in enumerate( expiry.iteritems() ):
        if i < len(expiry) - 1:
            weights.ix[prev_date:ex_date - pd.offsets.BDay(), item] = 1
            roll_rng = pd.date_range(end=ex_date - pd.offsets.BDay(),
                                     periods=roll_periods + 1, freq='B')
            decay_weights = np.linspace(0, 1, roll_periods + 1)
            weights.ix[roll_rng, item] = 1 - decay_weights
            weights.ix[roll_rng, expiry.index[i + 1]] = decay_weights
        else:
            weights.ix[prev_date:, item] = 1
        prev_date = ex_date
    return weights

weights = get_roll_weights('3/11/2014', expiry, prices.columns)
print( weights.ix['2014-04-17' : '2014-04-28'] )

rolled_returns = (prices.pct_change() * weights).sum(1)
print( rolled_returns )

