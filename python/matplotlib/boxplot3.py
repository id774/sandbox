# boxplot3.py: Box plots of comma-separated rows from a file
#
# Description:
# Draw box plots from comma separated rows read out of data.csv in the current
# directory, show them, and save image.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 boxplot3.py
#
# Requirements:
# - Python 3
# - NumPy before 1.24, which still provides np.float
# - Matplotlib
# - data.csv in the current directory
#

import matplotlib.pyplot as plt
import numpy as np
import sys

def arrays_from_file(filename):
    output = []
    with open(filename, 'r') as infile:
        for line in infile:
            line = np.array(line.strip().split(','),
                            dtype=np.float)
            output.append(line)
    return output

plt.boxplot(arrays_from_file("data.csv"))
plt.show()
plt.savefig("image.png")
