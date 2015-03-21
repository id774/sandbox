import numpy as np
import pandas.io.data as data
import pandas as pd
import talib as ta
import matplotlib.pyplot as plt

# Download SP500 data with pandas
spyidx = data.get_data_yahoo('SPY', '2013-01-01')
analysis = pd.DataFrame(index=spyidx.index.values)
prices = np.array(spyidx.Close)

analysis['rsi'] = ta.RSI(prices)

slow, fast, signal = ta.MACD(prices, fastperiod=12, slowperiod=26, signalperiod=9)
analysis['slow'] = slow
analysis['fast'] = fast
analysis['signal'] = signal 

print(analysis)
