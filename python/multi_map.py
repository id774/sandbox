# coding:utf-8

import multiprocessing

def fuga(x):
    return x * x

def hoge():
    p = multiprocessing.Pool(4)
    print(p.map(fuga, list(range(10))))

if __name__ == "__main__":
    hoge()
