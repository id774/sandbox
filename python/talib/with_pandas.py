import numpy as np
from pandas_datareader import data
import pandas as pd
import talib as ta

# Download SP500 data with pandas
spyidx = data.get_data_yahoo('SPY', '2013-01-01')
analysis = pd.DataFrame(index=spyidx.index.values)
prices = np.array(spyidx.Close)

analysis['prices'] = prices
analysis['rsi'] = ta.RSI(prices)

slow, fast, signal = ta.MACD(
    prices, fastperiod=12, slowperiod=26, signalperiod=9)
analysis['slow'] = slow
analysis['fast'] = fast
analysis['signal'] = signal

weekly = prices
sma50_daily = ta.SMA(np.array(weekly), timeperiod=50)
sma200_daily = ta.SMA(np.array(weekly), timeperiod=200)
boll_upper_weekly, boll_middle_weekly, boll_lower_weekly = ta.BBANDS(
    weekly, timeperiod=200, nbdevup=2, nbdevdn=2, matype=0)
analysis['boll_upper_weekly'] = boll_upper_weekly
analysis['boll_middle_weekly'] = boll_middle_weekly
analysis['boll_lower_weekly'] = boll_lower_weekly

print(analysis)
