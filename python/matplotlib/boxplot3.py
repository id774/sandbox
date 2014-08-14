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
