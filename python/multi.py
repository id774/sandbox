# coding:utf-8
# multi.py: Start processes with multiprocessing
#
# Description:
# Start 100 multiprocessing processes and print their parent and child PIDs.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 multi.py
#
# Requirements:
# - Python 3
#

import multiprocessing
import os
def f(number):
    print(number, os.getppid(), os.getpid())

if __name__ == '__main__':
    jobs = []
    for i in range(100):
        p = multiprocessing.Process(target=f, args=(i,))
        jobs.append(p)
        p.start()

    for job in jobs:
        job.join()
