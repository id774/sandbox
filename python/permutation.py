#!/usr/bin/env python
# - * - coding: utf-8 - * -

import nltk
import sys
import re, pprint

def permutations(seq):
    if len(seq) <= 1:
        yield seq
    else:
        for perm in permutations(seq[1:]):
            for i in range(len(perm)+1):
                yield perm[:i] + seq[0:1] + perm[i:]

def main():
    print list(permutations(['a', 'b', 'c', 'd']))

if __name__=='__main__':
    main()

