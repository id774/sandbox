#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
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
        for k, v in sorted(self.dic.items(), key=lambda x: int(x[1]), reverse=True):
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
