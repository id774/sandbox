import sys
import numpy as np
import matplotlib.pyplot as plt
import pandas

class PCA:

    def transform(self, X, dim):
        # 共分散行列
        X_bar = np.array([row - np.mean(row)
                          for row in X.transpose()]).transpose()
        m = np.dot(X_bar.T, X_bar) / X.shape[0]

        # 固有値問題
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
        # w_sorted = np.array(sorted(w, reverse=True))

        # 次元削減
        components = v_sorted[:dim, ]
        X_pca = np.dot(X_bar, components.T)

        return X_pca


def plot(X_pca, Y):
    s = np.array(
        [x for i, x in enumerate(X_pca) if Y[i] == "Iris-setosa"])
    ve = np.array(
        [x for i, x in enumerate(X_pca) if Y[i] == "Iris-versicolor"])
    vi = np.array(
        [x for i, x in enumerate(X_pca) if Y[i] == "Iris-virginica"])

    # colors = ['b.', 'r.', 'k.']
    fig, ax = plt.subplots()
    ax.plot(s[:, 0], s[:, 1], 'b.', label='Setosa')
    ax.plot(ve[:, 0], ve[:, 1], 'r.', label='Versicolour')
    ax.plot(vi[:, 0], vi[:, 1], 'k.', label='Virginica')

    ax.set_title("PCA for iris")
    ax.legend(numpoints=1)

    plt.show()
    plt.savefig("image.png")

def main(args):
    names = ["sl", "sw", "pl", "pw", "class"]
    data = pandas.read_csv("iris.csv", names=names)

    X = data.as_matrix()[0:150, 0:4].astype(np.float)
    Y = data.as_matrix()[0:150, 4:]

    pca = PCA()
    X_pca = pca.transform(X, 2)

    print(X_pca)

    plot(X_pca, Y)

    return 0

if __name__ == '__main__':
    argsmin = 0
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
