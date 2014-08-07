#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, os
import codecs

class Analyzer:
    def __init__(self, args):
        self.infile = args[1]
        self.key = ""

    def _read_from_file(self):
        file = open(self.infile, 'r')
        for line in file:
            tarfile, timestamp, mac_str, area, rssi_val, humandate, interval = line.rstrip().split("\t")
            if self.key == tarfile:
                self.f.write(line)
            else:
                if not self.key == "":
                    self.f.close
                self.key = tarfile
                outfile = os.path.splitext(self.infile)[0] + "_" + self.key + ".txt"
                self.f = codecs.open('%s' % outfile, 'w', 'utf-8')
                self.f.write(line)
        self.f.close
        file.close

    def main(self):
        self._read_from_file()

if __name__ == '__main__':
    argsmin = 1
    version = (3,0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            analyzer = Analyzer(sys.argv)
            analyzer.main()
        else:
            print("This program needs at least %(argsmin)s arguments" %locals())
    else:
        print("This program requires python > %(version)s" %locals())

