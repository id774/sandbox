#!/usr/bin/env python
# -*- coding: utf-8 -*-
# json_simple_analyzer.py: Total key counts across JSON records
#
# Description:
# Total the counts of each key across JSON records in a file given as an
# argument.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 json_simple_analyzer.py <input file>
#
# Requirements:
# - Python 3, which the program checks before running
#

import sys
import json
from collections import OrderedDict

class Analyzer:

    def __init__(self, args):
        self.filename = args[1]
        self.dic = OrderedDict()

    def start(self):
        file = open(self.filename, 'r')
        for line in file:
            key, tag, value = line.rstrip().split("\t")
            json_obj = json.loads(value)
            for word, count in json_obj.items():
                if word in self.dic:
                    self.dic[word] += count
                else:
                    self.dic[word] = count

        i = 0
        for k, v in sorted(self.dic.items(),
                           key=lambda x: int(x[1]), reverse=True):
            i += 1
            self.__output(i, k, v)
        file.close
        return self.dic

    def __output(self, key, tag, value):
        print(key, tag, value, sep="\t")

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
