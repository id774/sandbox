# iris.py: Pairwise scatter plots of the iris data set
#
# Description:
# Scatter the iris data set across each pair of its features and save the
# figure as image.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 iris.py
#
# Requirements:
# - Python 3
# - scikit-learn and Matplotlib
#

import itertools

from matplotlib import pyplot as plt
from sklearn import datasets


def main():
    iris = datasets.load_iris()

    # The feature data, four dimensions
    features = iris.data
    # Name of each feature
    feature_names = iris.feature_names
    # Which species each row belongs to
    targets = iris.target

    # Set the overall figure size
    plt.figure(figsize=(12, 8))

    # Build feature pairs, since each subplot is two dimensional
    for i, (x, y) in enumerate(itertools.combinations(range(4), 2)):
        # Subplot
        plt.subplot(2, 3, i + 1)
        # Give each species its own marker colour and shape
        for t, marker, c in zip(range(3), '>ox', 'rgb'):
            plt.scatter(
                features[targets == t, x],
                features[targets == t, y],
                marker=marker,
                c=c,
            )
            plt.xlabel(feature_names[x])
            plt.ylabel(feature_names[y])
            plt.autoscale()
            plt.grid()

    plt.show()
    plt.savefig('image.png')


if __name__ == '__main__':
    main()
