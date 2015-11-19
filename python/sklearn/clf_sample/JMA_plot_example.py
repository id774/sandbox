import matplotlib.pyplot as plt
plt.style.use('ggplot')
import numpy as np
import pandas as pd

jma_df = pd.read_csv(
    'JMA_3city.csv', index_col=0, parse_dates=True,
    header=None,
    skiprows=6,
    encoding='Shift_JIS')
df = jma_df.iloc[:, [0, 12, 24]]
df.columns = ['Tokyo', 'Fukuoka', 'Sapporo']
df.index.name = 'Date'
print(df.head(10))
plt.figure()
df.plot()
plt.savefig('image.png')
plt.close()

plt.figure()
df.plot.hist(bins=100, alpha=0.5)
plt.savefig('image2.png')
plt.close()

plt.figure()
monthly = df.groupby(pd.Grouper(level=0, freq='M')).mean()
monthly.index = ['14/' + str(x) for x in np.arange(1, 13)]
print(monthly.head(10))
monthly.plot.bar(color=['#348ABD', '#7A68A6', '#A60628'])
plt.savefig('image3.png')
plt.close()

plt.figure()
df.plot(kind='scatter', x='Sapporo', y='Fukuoka')
plt.savefig('image4.png')
plt.close()

plt.figure()
df.plot(kind='scatter', x='Sapporo', y='Fukuoka',
        c=df.index.month, cmap='winter')
plt.savefig('image5.png')
plt.close()

df = jma_df.iloc[:, [6, 9, 18, 21, 30, 33]]
df.columns = ['Tokyo-High', 'Tokyo-Low', 'Fukuoka-High',
              'Fukuoka-Low', 'Sapporo-High', 'Sapporo-Low']
df.index.name = 'Date'
print(df.head(10))
plt.figure()
df.plot()
plt.savefig('image6.png')
plt.close()
