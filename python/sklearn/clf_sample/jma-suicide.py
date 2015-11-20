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

# Suicide
sui_df = pd.read_csv(
    'suicide_2014.csv', index_col=0, parse_dates=True)

merged = pd.merge(df_jma, sui_df,
                  left_index=True, right_index=True)
print(merged)

plt.figure()
merged.plot(kind='scatter', x='Tokyo_x', y='Tokyo_y',
            c=merged.index.month,
            cmap='winter')
plt.savefig('jma-suicide.png')
plt.close()
