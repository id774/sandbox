#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Print the first command line argument.

import sys

def main(args):
    filename = args[1]
    print(filename)

if __name__ == '__main__':
    if len(sys.argv) > 1:
        main(sys.argv)
