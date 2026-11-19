# pca3.py: Principal component analysis over a pandas data set
#
# Description:
# Implement principal component analysis over iris.csv from the current
# directory, reducing it to the number of components given as the argument.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 pca3.py <components>
#
# Requirements:
# - Python 3, which the program checks before running
# - NumPy before 1.24, which still provides np.float
# - SciPy from a release whose top-level namespace still provides NumPy
#   aliases such as scipy.dot
# - pandas before 1.0, which still provides DataFrame.as_matrix
# - iris.csv in the current directory
#

import sys
import numpy as np
import scipy as sp
import scipy.linalg as linalg
import pandas as pd


class PCA:

    def transform(self, data, base_num=1):
        N, dim = data.shape
        data_m = data.mean(0)
        data_new = data - data_m

        cov_mat = sp.dot(data_new.T, data_new) / float(N)
        l, vm = linalg.eig(cov_mat)
        axis = vm[:, l.argsort()[- min(base_num, dim):][:: -1]].T
        return axis.T

def main(args):
    names = ["sl", "sw", "pl", "pw", "class"]
    data = pd.read_csv("iris.csv", names=names)

    X = data.as_matrix()[0:150, 0:4].astype(np.float)
    # Y = data.as_matrix()[0:150, 4:]

    pca = PCA()
    X_pca = pca.transform(X, int(args[1]))

    print(X_pca)

    return 0

if __name__ == '__main__':
    argsmin = 1
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
