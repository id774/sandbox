# -*- coding:utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

# X 座標を適当にサンプリングして指定、それに合わせて y = sin(x) + noise を生成
np.random.seed(1)
x = np.sort(np.random.uniform(-np.pi, np.pi, 100))
y = np.sin(x) + 0.1 * np.random.normal(size=len(x))

# scikit-learn に突っ込むためにフォーマット変更
x = x.reshape((len(x), 1))

# 全データの描画
plt.plot(x, y, 'o')
plt.show()
plt.savefig("image.png")
