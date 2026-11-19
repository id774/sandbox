# prof_mod.py: Array addition workload for profiling
#
# Description:
# Provide an array addition workload for profiling.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 -m cProfile prof_mod.py
#
# Requirements:
# - Python 3, which the program checks before running
# - NumPy
#

import sys
from numpy.random import randn

def add_and_sum(x, y):
    added = x + y
    summed = added.sum(axis=1)
    return summed

def call_func():
    x = randn(1000, 1000)
    y = randn(1000, 1000)
    return add_and_sum(x, y)

def main(args):
    print(call_func())

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
