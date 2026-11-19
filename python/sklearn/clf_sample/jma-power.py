# jma-power.py: Monthly power demand against temperature
#
# Description:
# Scatter monthly power demand from juyo-2014.csv against temperature from
# JMA_3city.csv, saving jma-power.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 jma-power.py
#
# Requirements:
# - Python 3
# - NumPy, pandas, and Matplotlib
# - juyo-2014.csv and JMA_3city.csv in the current directory
#

import matplotlib.pyplot as plt
plt.style.use('ggplot')
import numpy as np
import pandas as pd

# JMA
jma_df = pd.read_csv(
    'JMA_3city.csv', index_col=0, parse_dates=True,
    header=None,
    skiprows=6,
    encoding='Shift_JIS')
df = jma_df.iloc[:, [0, 12, 24]]
df.columns = ['Tokyo', 'Fukuoka', 'Sapporo']
df.index.name = 'Date'
df_jma = df.groupby(pd.Grouper(level=0, freq='M')).mean()
# print(df_jma.head(10))

# Power
datafile = 'juyo-2014.csv'
df_power = pd.read_csv(datafile,
                       skiprows=3,
                       names=['date', 'time', 'Power'],
                       encoding='Shift_JIS')
idx_power = pd.to_datetime(df_power['date'] + ' ' + df_power['time'])
df_power.index = idx_power
del df_power['date']
del df_power['time']
df_power_monthly = df_power.groupby(pd.Grouper(level=0, freq='M')).mean()
# print(df_power_monthly.head(10))

merged = pd.merge(df_jma, df_power_monthly,
                  left_index=True, right_index=True)
print(merged)

plt.figure()
merged.plot(kind='scatter', x='Tokyo', y='Power',
            c=merged.index.month,
            cmap='spring')
plt.savefig('jma-power.png')
plt.close()
