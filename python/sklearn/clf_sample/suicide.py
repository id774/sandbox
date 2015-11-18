import matplotlib.pyplot as plt
plt.style.use('ggplot')
import pandas as pd

df = pd.read_csv('201401.csv', index_col=0, skiprows=7, encoding='shift_jis')
df = df.iloc[[0, 12, 39], [0, 1]]
df.columns = ['City', 'Num']
print(df)
