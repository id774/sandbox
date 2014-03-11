# -*- coding:utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
from sklearn import svm
from sklearn import cross_validation

# X 座標を適当にサンプリングして指定、それに合わせて y = sin(x) + noise を生成
np.random.seed(1)
x = np.sort(np.random.uniform(-np.pi, np.pi,100))
y = np.sin(x) + 0.1*np.random.normal(size=len(x))

# scikit-learn に突っ込むためにフォーマット変更
x = x.reshape((len(x),1))

# データを 6 割をトレーニング、 4 割をテスト用とする
x_train, x_test, y_train, y_test = cross_validation.train_test_split(x, y, test_size=0.4)

# 線でつないで plot する用に x_test, y_test を x_test の昇順に並び替える
index = x_test.argsort(0).reshape(len(x_test))
x_test = x_test[index]
y_test = y_test[index]

# サポートベクトル回帰を学習データ使って作成
reg = svm.SVR(kernel='rbf', C=1).fit(x_train, y_train)

# テストデータに対する予測結果のPLOT
plt.plot(x_test, y_test, 'bo-', x_test, reg.predict(x_test), 'ro-')
plt.show()
plt.savefig("image.png")

# 決定係数R^2
print(reg.score(x_test, y_test))
