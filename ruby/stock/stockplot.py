import sys
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import font_manager

prop = font_manager.FontProperties(
    fname="/usr/share/fonts/truetype/fonts-japanese-gothic.ttf")

class Analyzer:
    def __init__(self, args):
        pass

    def draw(self, code):
        plt.figure()
        filename = 'stock_' + code
        ext = '.csv'
        df = pd.read_csv(filename + ext, parse_dates=True, index_col=0)
        df.ix[:, 4].plot(label="Low", color="k")
        df.ix[:, 3].plot(label="High", color="r")
        df.ix[:, 1].plot(label="Open", color="g")
        df.ix[:, 2].plot(label="Close", color="b")
        plt.legend(loc='best')
        ext = '.png'
        plt.ylabel('Stock of ' + code)
        plt.xlabel('Date')
        plt.savefig(filename + ext)
        plt.close()

    def start(self):
        stocks = pd.read_csv('stocks.txt', header=None)
        for s in stocks.values:
            self.draw(str(s[0]))

if __name__ == '__main__':
    argsmin = 0
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            analyzer = Analyzer(sys.argv)
            analyzer.start()
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
