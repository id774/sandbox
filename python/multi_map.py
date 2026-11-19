# coding:utf-8
# multi_map.py: Square numbers with a multiprocessing pool
#
# Description:
# Square a range of numbers across a multiprocessing pool of four workers.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 multi_map.py
#
# Requirements:
# - Python 3
#

import multiprocessing

def fuga(x):
    return x * x

def hoge():
    p = multiprocessing.Pool(4)
    print(p.map(fuga, list(range(10))))

if __name__ == "__main__":
    hoge()
