import numpy as np
import matplotlib.pyplot as plt

# 主成分分析の実装
class PCA:

    # 主成分分析による次元削減

    def transform(self, X, dim):
        # 共分散行列を求める
        X_bar = np.array([row - np.mean(row)
                          for row in X.transpose()]).transpose()
        m = np.dot(X_bar.T, X_bar) / X.shape[0]
        # 固有値問題を解く
        (w, v) = np.linalg.eig(m)
        v = v.T

        # 固有値の大きい順に固有値と固有ベクトルをソート
        tmp = {}
        for i, value in enumerate(w):
            tmp[value] = i

        v_sorted = []
        for key in sorted(tmp.keys(), reverse=True):
            v_sorted.append(v[tmp[key]])
        v_sorted = np.array(v_sorted)
        print(v_sorted)

        w_sorted = np.array(sorted(w, reverse=True))
        print(w_sorted)

        # 次元削減
        components = v_sorted[:dim, ]
        X_pca = np.dot(X_bar, components.T)

        return X_pca

# pandasを用いてデータを読み込む
import pandas

names = ["sl", "sw", "pl", "pw", "class"]
data = pandas.read_csv("iris.csv", names=names)

X = data.as_matrix()[0:150, 0:4].astype(np.float)
Y = data.as_matrix()[0:150, 4:]

# 主成分分析前のサイズ
print(X.shape)

# 主成分分析
pca = PCA()
X_pca = pca.transform(X, dim=2)

# 主成分分析後のサイズ
print(X_pca.shape)

# 可視化
s = np.array([x for i, x in enumerate(X_pca) if Y[i] == "Iris-setosa"])
ve = np.array([x for i, x in enumerate(X_pca) if Y[i] == "Iris-versicolor"])
vi = np.array([x for i, x in enumerate(X_pca) if Y[i] == "Iris-virginica"])

colors = ['b.', 'r.', 'k.']
fig, ax = plt.subplots()
ax.plot(s[:, 0], s[:, 1], 'b.', label='Setosa')
ax.plot(ve[:, 0], ve[:, 1], 'r.', label='Versicolour')
ax.plot(vi[:, 0], vi[:, 1], 'k.', label='Virginica')

ax.set_title("PCA for iris")
ax.legend(numpoints=1)

plt.show()
plt.savefig("image.png")
