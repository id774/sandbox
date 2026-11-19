# heatmap.py: Labelled heatmap drawn with pcolor
#
# Description:
# Draw a labelled heatmap of a random square matrix whose size is given as an
# argument, and save it as image.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 heatmap.py <size>
#
# Requirements:
# - Python 3, which the program checks before running
# - NumPy and Matplotlib
#

import sys
import matplotlib.pyplot as plt
import numpy as np

def draw_heatmap(data, row_labels, column_labels):
    fig, ax = plt.subplots()
    heatmap = ax.pcolor(data, cmap=plt.cm.Blues)

    ax.set_xticks(np.arange(data.shape[0]) + 0.5, minor=False)
    ax.set_yticks(np.arange(data.shape[1]) + 0.5, minor=False)

    ax.invert_yaxis()
    ax.xaxis.tick_top()

    ax.set_xticklabels(row_labels, minor=False)
    ax.set_yticklabels(column_labels, minor=False)
    plt.show()
    plt.savefig('image.png')

    return heatmap

def main(args):
    size = int(args[1])
    x_labels = np.arange(0, size)
    y_labels = np.arange(0, size)
    data = np.random.rand(size, size)

    heatmap = draw_heatmap(data, x_labels, y_labels)
    return heatmap

if __name__ == '__main__':
    argsmin = 1
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            heatmap = main(sys.argv)
            print(heatmap)
            sys.exit(0)
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
