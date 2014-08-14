#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

def main(args):
    filename = args[1]
    print(filename)

if __name__ == '__main__':
    if len(sys.argv) > 1:
        main(sys.argv)
