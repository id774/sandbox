#!/usr/bin/env python
# -*- coding: utf-8 -*-
# file_cutter.py: Extract tab-separated lines that start with a date
#
# Description:
# Extract the tab separated lines whose first field starts with a given date.
# The matching lines are written in UTF-8 to <input base name>_<date>.txt
# beside the input file.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 file_cutter.py <input file> <date prefix>
#
# Requirements:
# - Python 3, which the program checks before running
#

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
