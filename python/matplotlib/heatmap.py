import sys
import matplotlib.pyplot as plt
import numpy as np

def draw_heatmap(data, column_labels, row_labels):
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
    column_labels = list('ABCD')
    row_labels = list('WXYZ')
    data = np.random.rand(4, 4)

    heatmap = draw_heatmap(data, column_labels, row_labels)
    return heatmap

if __name__ == '__main__':
    argsmin = 0
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
