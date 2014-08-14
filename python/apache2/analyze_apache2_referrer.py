#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import json
import re
from collections import OrderedDict
import urllib.request

class Analyzer:

    def __init__(self, args):
        self.infile = args[1]
        self.dic = OrderedDict()

    def _append_dic(self, word):
        if word in self.dic:
            self.dic[word] += 1
        else:
            self.dic[word] = 1

    def _read_from_file(self):
        referrers = []
        file = open(self.infile, 'r')
        for line in file:
            self._append_dic(line.rstrip().split('"')[3])
        for word, count in self.dic.items():
            print(word, count, sep="\t")
        file.close

    def start(self):
        self._read_from_file()

if __name__ == '__main__':
    argsmin = 1
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
