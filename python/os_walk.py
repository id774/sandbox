#!/usr/bin/env python
# -*- coding: utf-8 -*-
# os_walk.py: Print every file path under a directory
#
# Description:
# Print the full path of every file under a directory with os.walk.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 os_walk.py <directory>
#
# Requirements:
# - Python 3
#

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
