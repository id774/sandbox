#!/usr/bin/env python
# -*- coding: utf-8 -*-
# extract_title_from_json.py: Collect title fields from JSON records in a TSV file
#
# Description:
# Collect the title field from JSON records in a tab separated file given as
# an argument.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 extract_title_from_json.py <input file>
#
# Requirements:
# - Python 3, which the program checks before running
#

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
