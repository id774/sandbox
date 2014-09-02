import sys
import numpy as np
import matplotlib.pyplot as plt

def draw_heatmap(x, y):
    heatmap, xedges, yedges = np.histogram2d(x, y, bins=50)
    extent = [xedges[0], xedges[-1], yedges[0], yedges[-1]]

    plt.figure()
    plt.imshow(heatmap, extent=extent)
    plt.show()
    plt.savefig('image.png')

def main(args):
    t = int(args[1])

    rand = lambda x: np.random.randn(x)
    x = rand(t)
    y = rand(t)

    draw_heatmap(x, y)
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
