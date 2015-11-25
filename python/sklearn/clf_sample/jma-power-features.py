import matplotlib.pyplot as plt
plt.style.use('ggplot')
import pandas as pd
import numpy as np

# JMA
def read_jma(filename):
    jma_df = pd.read_csv(filename,
                         index_col=0, parse_dates=True,
                         header=None,
                         skiprows=6,
                         encoding='Shift_JIS')
    df = jma_df.iloc[:, [0, 12, 24]]
    df.columns = ['Tokyo', 'Fukuoka', 'Sapporo']
    df.index.name = 'Date'
    return df

df_jma = read_jma('JMA_3city_2014.csv')
# print(df_jma['Tokyo'])
# print(len(df_jma['Tokyo'].values))
# print(df_jma['Tokyo'].values[0])
# print(df_jma['Tokyo'].values[364])

# Power
def read_power(filename):
    df_power = pd.read_csv(filename,
                           skiprows=3,
                           names=['date', 'time', 'Power'],
                           encoding='Shift_JIS')
    idx_power = pd.to_datetime(df_power['date'] + ' ' + df_power['time'])
    df_power.index = idx_power
    del df_power['date']
    del df_power['time']
    return df_power.resample('D', how='max', kind='period')


df_power_daily = read_power('juyo-2014.csv')
# print(df_power_daily['Power'])
# print(len(df_power_daily['Power'].values))

def features(x, y, range=365):
    train_X = []
    train_y = []
    for i in np.arange(0, range):
        train_X.append([x[i]])
        train_y.append(y[i])
    return train_X, train_y

x = df_jma['Tokyo'].values.tolist()
y = df_power_daily['Power'].values.tolist()
x, y = features(x, y, range=365)

# Machine Learning
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
predicted = clf.predict(x)
# for (a, b) in zip (predicted, y):
#     print(a, b)

plt.figure()
plt.plot(predicted, label="predicted",
         color="r")
plt.plot(y, label="actual",
         color="g")
plt.legend(loc='best')
plt.savefig('image.png')
plt.close()

corr = np.corrcoef(predicted, y)
print(corr[0, 1])
