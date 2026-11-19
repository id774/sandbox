#!/usr/bin/env python
# -*- coding: utf-8 -*-
# file_splitter.py: Split a tab-separated file by its first field
#
# Description:
# Split a tab separated file into one output file per value of the first
# field. Each run of consecutive lines with the same first field is written in
# UTF-8 to <input base name>_<field>.txt beside the input file.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 file_splitter.py <input file>
#
# Requirements:
# - Python 3, which the program checks before running
#

import sys
import os
import codecs

class FileSplitter:

    def __init__(self, args):
        self.infile = args[1]
        self.key = ""

    def split(self):
        file = open(self.infile, 'r')
        for line in file:
            (tarfile, timestamp, mac_str, area,
                rssi_val, humandate, interval) = line.rstrip(
            ).split("\t")
            if self.key == tarfile:
                self.f.write(line)
            else:
                if not self.key == "":
                    self.f.close
                self.key = tarfile
                outfile = os.path.splitext(
                    self.infile)[0] + "_" + self.key + ".txt"
                self.f = codecs.open('%s' % outfile, 'w', 'utf-8')
                self.f.write(line)
        self.f.close
        file.close

    def main(self):
        self.split()

if __name__ == '__main__':
    argsmin = 1
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            splitter = FileSplitter(sys.argv)
            splitter.main()
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
