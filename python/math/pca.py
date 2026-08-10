# Reduce data with principal component analysis under a maximum variance criterion.

import sys
import scipy as sp
import scipy.linalg as linalg
from matplotlib import pylab as plt

# =================
#  Principal component analysis (PCA)
# =================
"""
Maximum Variance criterion
"""

def pca(data, base_num=1):
    N, dim = data.shape

    data_m = data.mean(0)
    data_new = data - data_m

    # More rows than dimensions
    if N > dim:
        # Covariance matrix of the data matrix
        cov_mat = sp.dot(data_new.T, data_new) / float(N)
        # Compute the eigenvalues and eigenvectors
        l, vm = linalg.eig(cov_mat)
        # Sort by descending eigenvalue
        axis = vm[:, l.argsort()[- min(base_num, dim):][:: -1]].T

    # More dimensions than rows
    else:
        base_num = min(base_num, N)
        cov_mat = sp.dot(data_new, data_new.T) / float(N)
        l, v = linalg.eig(cov_mat)
        # Sort the eigenvalues and eigenvectors
        idx = l.argsort()[::-1]
        l = l[idx]
        v = vm[:, idx]
        # Transform the eigenvectors
        vm = sp.dot(data_m.T, v[:, : base_num])
        # Compute the basis of the principal components
        axis = sp.zeros([base_num, dim], dtype=sp.float64)
        for ii in range(base_num):
            if l[ii] <= 0:
                break
            axis[ii] = vm[:, ii] / linalg.norm(vm[:, ii])

    return axis

# ========
#  Test
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
