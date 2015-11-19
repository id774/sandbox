import matplotlib.pyplot as plt
plt.style.use('ggplot')
import pandas as pd
import numpy as np

month = (['20140' + str(x) for x in np.arange(1, 10)]) + \
    (['2014' + str(x) for x in np.arange(10, 13)])
print(month)

cities = ['Tokyo', 'Fukuoka', 'Sapporo']

total_df = pd.DataFrame([], columns=cities)

for m in month:
    df = pd.read_csv(m + '.csv', index_col=0, skiprows=7, encoding='shift_jis')
    df = df.iloc[[12, 39, 0], [0, 1]]
    df.columns = ['City', 'Num']
    total_df.ix[m, :] = df['Num'].values

total_df.columns = cities
print(total_df)
total_df.to_csv('suicide_2014.csv')
