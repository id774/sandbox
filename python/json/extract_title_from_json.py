#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import json

class Extractor:

    def __init__(self, args):
        self.filename = args[1]

    def get_title(self):
        arr = []
        file = open(self.filename, 'r')
        for line in file:
            key, tag, value = line.rstrip().split("\t")
            json_obj = json.loads(value)
            for key, value in json_obj.items():
                if key == 'title':
                    arr.append(value)

        file.close
        return arr

    def __output(self, key, tag, value):
        print(key, tag, value, sep="\t")

if __name__ == '__main__':
    argsmin = 1
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            extractor = Extractor(sys.argv)
            result = extractor.get_title()
            print(result)
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
