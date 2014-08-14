#!/usr/bin/env python
# - * - coding: utf-8 - * -

import nltk
import math

"""
>>> import entropy
>>> entropy.entropy(['male', 'male', 'female', 'male'])
0.811278124459
"""

def entropy(labels):
    freqdist = nltk.FreqDist(labels)
    probs = [freqdist.freq(l) for l in nltk.FreqDist(labels)]
    return -sum([p * math.log(p, 2) for p in probs])

def main():
    print entropy(['male', 'male', 'female', 'male'])

if __name__ == '__main__':
    import doctest
    doctest.testmod()
    main()
