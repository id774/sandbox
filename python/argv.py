#!/usr/bin/env python
# -*- coding: utf-8 -*-
# argv.py: Print the first command line argument
#
# Description:
# Print the first command line argument.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 argv.py <argument>
#
# Requirements:
# - Python 3
#

import sys

def main(args):
    filename = args[1]
    print(filename)

if __name__ == '__main__':
    if len(sys.argv) > 1:
        main(sys.argv)
