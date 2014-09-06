import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats
from pandas.tools.plotting import scatter_matrix

df = pd.read_csv('data.csv', names=['X', 'Y', 'Z'])
plt.figure()
print(df.describe())
df.boxplot()
plt.savefig('image.png')

print(stats.linregress(df['X'], df['Z']))
