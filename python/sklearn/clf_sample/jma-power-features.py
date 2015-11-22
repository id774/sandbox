import matplotlib.pyplot as plt
plt.style.use('ggplot')
import pandas as pd
import numpy as np

jma_df = pd.read_csv(
    'JMA_3city.csv', index_col=0, parse_dates=True,
    header=None,
    skiprows=6,
    encoding='Shift_JIS')
df = jma_df.iloc[:, [0, 12, 24]]
df.columns = ['Tokyo', 'Fukuoka', 'Sapporo']
df.index.name = 'Date'
# print(df['Tokyo'].values)
# print(len(df['Tokyo'].values))
# print(df['Tokyo'].values[0])
# print(df['Tokyo'].values[364])

datafile = 'juyo-2014.csv'
df_power = pd.read_csv(datafile,
                       skiprows=3,
                       names=['date', 'time', 'Power'],
                       encoding='Shift_JIS')
idx_power = pd.to_datetime(df_power['date'] + ' ' + df_power['time'])
df_power.index = idx_power
del df_power['date']
del df_power['time']
df_power_daily = df_power.resample('D', how='max', kind='period')
# print(df_power_daily['Power'].values)
# print(len(df_power_daily['Power'].values))

def features(x, y, range=365):
    train_X = []
    train_y = []
    for i in np.arange(0, range):
        train_X.append([x[i]])
        train_y.append(y[i])
    return train_X, train_y

x = df['Tokyo'].values.tolist()
y = df_power_daily['Power'].values.tolist()
x, y = features(x, y)

from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from sklearn.naive_bayes import GaussianNB, MultinomialNB, BernoulliNB
from sklearn.lda import LDA

names = ["Decision Tree",
         "Random Forest", "AdaBoost",
         "Gaussian Naive Bayes",
         "Multinomial Naive Bayes",
         "Bernoulli Naive Bayes",
         "LDA"]
classifiers = [
    DecisionTreeClassifier(max_depth=5),
    RandomForestClassifier(
        max_depth=5, n_estimators=10, max_features=1),
    AdaBoostClassifier(),
    GaussianNB(), MultinomialNB(), BernoulliNB(),
    LDA()]
dic = dict(zip(names, classifiers))
clf = dic["Gaussian Naive Bayes"]

# Fitting
# print(x)
# print(y)
clf.fit(x, y)

# Classify
answer = clf.predict(x)
for (a, b) in zip (answer, y):
    print(a, b)
