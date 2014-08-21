#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os

def list_files(path):
    for root, dirs, files in os.walk(path):
        for filename in files:
            fullname = os.path.join(root, filename)
            print(fullname)

def main(args):
    path = args[1]
    list_files(path)

if __name__ == '__main__':
    if len(sys.argv) > 1:
        main(sys.argv)
