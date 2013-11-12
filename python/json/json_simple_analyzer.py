#!/usr/bin/env python
# -*- coding: utf-8 -*-

# For after python3 (print, dic).

import sys, os
import json

class Analyzer:
    def __init__(self, args):
        self.filename = args[1]
        self.dic = {}

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
        for k, v in sorted(self.dic.items(), key=lambda x:int(x[1]), reverse=True):
            i += 1
            self.output(i, k, v)
        file.close

    def output(self, key, tag, value):
        print(key, tag, value, sep="\t")

if __name__=='__main__':
    if len(sys.argv) > 1:
        analyzer = Analyzer(sys.argv)
        analyzer.start()

