#!/usr/bin/env python

import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def plot(samples):
    s1 = pd.Series(np.random.poisson(5, samples))
    s2 = pd.Series(np.random.poisson(10, samples))
    s3 = pd.Series(np.random.poisson(20, samples))
    s0 = pd.Series([0] * len(s1))

    print("s1", s1)
    print("s2", s2)
    print("s3", s3)
    print("s1", s1.describe())
    print("s2", s2.describe())
    print("s3", s3.describe())

    plt.figure()
    boxes = [s1, s2, s3]
    plt.boxplot(boxes)
    boxes.insert(0, s0)
    plt.plot(boxes, marker='.', linestyle='None')

    xticks = ['A', 'B', 'C']
    plt.xticks([1, 2, 3], xticks)
    plt.grid()
    plt.ylabel('Length')
    plt.xlabel('type')

    plt.show()
    plt.savefig("image.png")

def main(args):
    samples = int(args[1])
    plot(samples)

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
