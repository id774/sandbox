
import sys
import scipy as sp
import scipy.linalg as linalg
from matplotlib import pylab as plt

# =================
#  主成分分析 (PCA)
# =================
"""
Maximum Variance criterion
"""

def pca(data, base_num=1):
    N, dim = data.shape

    data_m = data.mean(0)
    data_new = data - data_m

    # データ数 > 次元数
    if N > dim:
        # データ行列の共分散行列
        cov_mat = sp.dot(data_new.T, data_new) / float(N)
        # 固有値・固有ベクトルを計算
        l, vm = linalg.eig(cov_mat)
        # 固有値が大きい順に並び替え
        axis = vm[:, l.argsort()[- min(base_num, dim):][:: -1]].T

    # 次元数 > データ数
    else:
        base_num = min(base_num, N)
        cov_mat = sp.dot(data_new, data_new.T) / float(N)
        l, v = linalg.eig(cov_mat)
        # 固有値と固有ベクトルを並び替え
        idx = l.argsort()[::-1]
        l = l[idx]
        v = vm[:, idx]
        # 固有ベクトルを変換
        vm = sp.dot(data_m.T, v[:, : base_num])
        # （主成分の）基底を計算
        axis = sp.zeros([base_num, dim], dtype=sp.float64)
        for ii in range(base_num):
            if l[ii] <= 0:
                break
            axis[ii] = vm[:, ii] / linalg.norm(vm[:, ii])

    return axis

# ========
#  テスト
# ========
from numpy.random import multivariate_normal

def test(args):
    data = multivariate_normal([0, 0], [[1, 2], [2, 5]], int(args[1]))
    print(data)
    # PCA
    result = pca(data, base_num=int(args[2]))
    pc_base = result[0]
    print(pc_base)

    # Plotting
    fig = plt.figure()
    fig.add_subplot(1, 1, 1)
    plt.axvline(x=0, color="#000000")
    plt.axhline(y=0, color="#000000")
    # Plot data
    plt.scatter(data[:, 0], data[:, 1])
    # Draw the 1st principal axis
    pc_line = sp.array([-3., 3.]) * (pc_base[1] / pc_base[0])
    plt.arrow(0, 0, -pc_base[0] * 2, -pc_base[1] * 2,
              fc="r", width=0.15, head_width=0.45)
    plt.plot([-3, 3], pc_line, "r")
    # Settings
    plt.xticks(size=15)
    plt.yticks(size=15)
    plt.xlim([-3, 3])
    plt.tight_layout()
    plt.show()
    plt.savefig("image.png")

    return 0

if __name__ == '__main__':
    argsmin = 2
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(test(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
