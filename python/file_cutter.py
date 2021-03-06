#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import codecs

class FileCutter:

    def __init__(self, args):
        self.infile = args[1]
        self.keydate = args[2]
        self.outfile = os.path.splitext(
            self.infile)[0] + "_" + self.keydate + ".txt"

    def cut(self):
        file = open(self.infile, 'r')
        f = codecs.open('%s' % self.outfile, 'w', 'utf-8')
        for line in file:
            (tarfile, timestamp, mac_str,
                area, rssi_val, humandate, interval) = line.rstrip(
            ).split("\t")
            if tarfile.startswith(self.keydate):
                f.write(line)
        file.close
        f.close

    def main(self):
        self.cut()

if __name__ == '__main__':
    argsmin = 2
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            cutter = FileCutter(sys.argv)
            cutter.main()
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
