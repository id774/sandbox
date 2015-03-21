import numpy as np
import talib
from talib import MA_Type
from talib import abstract
from talib.abstract import *

close = np.random.random(100)
output = talib.SMA(close)
print(output)
upper, middle, lower = talib.BBANDS(close, matype=MA_Type.T3)
output = talib.MOM(close, timeperiod=5)
print(output)

# note that all ndarrays must be the same length!
inputs = {
    'open': np.random.random(100),
    'high': np.random.random(100),
    'low': np.random.random(100),
    'close': np.random.random(100),
    'volume': np.random.random(100)
}
# directly
sma = abstract.SMA
print(sma)
# or by name
sma = abstract.Function('sma')
print(sma)
# uses close prices (default)
output = SMA(inputs, timeperiod=25)
print(output)
# uses open prices
output = SMA(inputs, timeperiod=25, price='open')
print(output)
# uses close prices (default)
upper, middle, lower = BBANDS(inputs, 20, 2, 2)
print((upper, middle, lower))
# uses high, low, close (default)
slowk, slowd = STOCH(inputs, 5, 3, 0, 3, 0)  # uses high, low, close by default
print((slowk, slowd))
# uses high, low, open instead
slowk, slowd = STOCH(inputs, 5, 3, 0, 3, 0, prices=['high', 'low', 'open'])
print((slowk, slowd))
print((talib.MACD(close)))
