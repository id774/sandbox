# -*- coding:utf-8 -*-

import sys
import json
import collections

def convert(args):
    filename = args[1]

    decoder = json.JSONDecoder(object_pairs_hook=collections.OrderedDict)

    with open(filename) as json_file:
        data = decoder.decode(json_file.read())

    data[0] = 'append last'

    with open(filename, 'w') as json_file:
        json.dump(data, json_file, indent=4, separators=(',', ': '))

if __name__ == '__main__':
    argsmin = 1
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            convert(sys.argv)
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
