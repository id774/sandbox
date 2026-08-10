# coding:utf-8
# Start 100 multiprocessing processes and print their parent and child PIDs.

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
