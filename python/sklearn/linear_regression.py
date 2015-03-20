
# http://nbviewer.ipython.org/github/takashi-miyamoto-naviplus/spml4dm/blob/master/1/boston.ipynb

# Import libs
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn import datasets
from pandas.tools.plotting import scatter_matrix

# Load Dataset
boston = datasets.load_boston()
keys = boston.keys()
shapes = boston.data.shape
names = boston.feature_names
df = pd.DataFrame(boston.data)

df.columns = names
df['MEDV'] = boston.target

print(df.head())
print(df.describe())

plt.figure()
plt.hist(df.MEDV)
plt.title('Housing prices')
plt.xlabel('price')
plt.ylabel('frequency')
plt.savefig('image.png')
plt.close()

plt.figure()
plt.scatter(df.RM, df.MEDV)
plt.title('Average Number of Rooms vs Housing prices')
plt.xlabel('average number of rooms')
plt.ylabel('price')
plt.savefig('image2.png')
plt.close()

plt.figure()
scatter_matrix(df, figsize=(14, 14), diagonal='hist')
plt.title('Scatter Matrix of Housing prices')
plt.savefig('image3.png')
plt.close()

plt.figure()
corrs = df.corr()
plt.pcolor(corrs, cmap='bwr', vmin=-1.0, vmax=1.0)
plt.title('Correlation coefficient of Housing prices')
plt.yticks(np.arange(0.5, len(corrs.index), 1), corrs.index)
plt.xticks(np.arange(0.5, len(corrs.columns), 1), corrs.columns)
plt.colorbar()
plt.savefig('image4.png')
plt.close()

plt.figure()
from sklearn.linear_model import LinearRegression
lr = LinearRegression(normalize=True)
lr.fit(boston.data, boston.target)
predicted = lr.predict(boston.data)
plt.hist(boston.target - predicted, bins=50)
plt.title('Linear Regression with sklearn of Housing prices')
plt.show()
plt.savefig('image5.png')
plt.close()
print('Linear Regression')
print(lr.rank_)
print([x for x in zip(names, lr.coef_)])

from sklearn.linear_model import RidgeCV
rcv = RidgeCV(
    alphas=np.array([0.001, 0.003, 0.01, 0.03, 0.1, 0.3, 1.0]), normalize=True)
rcv.fit(boston.data, boston.target)
print('RidgeCV')
print(rcv.alpha_)
print([x for x in zip(boston.feature_names, rcv.coef_)])

from sklearn.linear_model import LassoCV
lcv = LassoCV(
    alphas=np.array([0.001, 0.003, 0.01, 0.03, 0.1, 0.3, 1.0]), normalize=True)
lcv.fit(boston.data, boston.target)
print('LassoCV')
print(lcv.alpha_)
print([x for x in zip(boston.feature_names, lcv.coef_)])

from sklearn.linear_model import ElasticNetCV
encv = ElasticNetCV(alphas=np.array([0.0001, 0.0003, 0.01, 0.03, 0.1, 0.3, 1.0]),
                    l1_ratio=np.array([0.5, 0.8, 0.9, 0.95, 0.99, 0.995, 1.0]), normalize=True)
encv.fit(boston.data, boston.target)
print('ElasticNetCV')
print([x for x in zip(boston.feature_names, encv.coef_)])
