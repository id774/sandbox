import matplotlib.pyplot as plt
plt.style.use('ggplot')
import numpy as np
import pandas as pd

df = pd.read_csv(
    'JMA_3city.csv', index_col=0, parse_dates=True,
    header=[0, 1, 2], encoding='utf8')
df = df.iloc[:, [0, 6, 12]]
df.columns = ['Tokyo', 'Fukuoka', 'Sapporo']
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
