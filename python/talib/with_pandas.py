import numpy as np
import pandas.io.data as data
import pandas as pd
import talib as ta
import matplotlib.pyplot as plt

# Download SP500 data with pandas
spyidx = data.get_data_yahoo('SPY', '2013-01-01')
analysis = pd.DataFrame(index=spyidx.index.values)
analysis['rsi'] = ta.RSI(np.array(spyidx.Close))
print(analysis)
