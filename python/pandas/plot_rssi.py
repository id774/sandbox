import sys
import pandas as pd
import matplotlib.pyplot as plt

class Analyzer:
    def __init__(self, args):
        self.infile = args[1]
        self.prefix = args[2]
        self.file_prefix = self.prefix.replace(' ','_')
        self.dic = {}

    def _plot_dic(self):
        s = pd.Series(self.dic)
        s.to_csv(self.file_prefix + '.csv')
        fig = plt.figure()
        ax = fig.add_subplot(1,1,1)
        s.plot(kind='bar')
        plt.show()
        plt.savefig(self.file_prefix + '.png')

    def _read_from_file(self):
        file = open(self.infile, 'r')
        for line in file:
            tarfile, timestamp, key, area, rssi_val, humantime, interval = line.rstrip().split("\t")
            if humantime.startswith(self.prefix):
                if area in self.dic:
                    self.dic[area] += 1
                else:
                    self.dic[area] = 1

    def main(self):
        self._read_from_file()
        self._plot_dic()

if __name__ == '__main__':
    argsmin = 2
    version = (3,0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            analyzer = Analyzer(sys.argv)
            analyzer.main()
        else:
            print("This program needs at least %(argsmin)s arguments" %locals())
    else:
        print("This program requires python > %(version)s" %locals() )

