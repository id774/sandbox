import matplotlib.pyplot as plt
plt.style.use('ggplot')
import pandas as pd

datafile = 'http://www.tepco.co.jp/forecast/html/images/juyo-2014.csv'
df_power = pd.read_csv(datafile,
                       skiprows=3,
                       names=['date', 'time', 'actual'],
                       encoding='Shift_JIS')
idx_power = pd.to_datetime(df_power['date'] + ' ' + df_power['time'])
df_power.index = idx_power
del df_power['date']
del df_power['time']
df_power_daily = df_power.resample('D', how='max', kind='period')
print(df_power_daily.head(10))
df_power_monthly = df_power_daily.resample('M', how='max', kind='period')
print(df_power_monthly.head(10))

plt.figure()
df_power_daily.plot()
plt.savefig('image6.png')
plt.close()
