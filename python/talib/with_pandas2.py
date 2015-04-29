import os
import numpy as np
import pandas as pd
import talib as ta

days = 30
filename = os.path.join(os.path.dirname(
                        os.path.abspath(__file__)),
                        'stock_N225.csv')
stock_tse = pd.read_csv(filename,
                        index_col=0, parse_dates=True)
stock_d = stock_tse.asfreq('B')[days:]

analysis = pd.DataFrame(index=stock_d['Adj Close'].dropna().index.values)
prices = np.array(stock_d['Adj Close'].dropna())

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
