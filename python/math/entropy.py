#!/usr/bin/env python
# - * - coding: utf-8 - * -
# entropy.py: Shannon entropy of a label sequence
#
# Description:
# Compute the Shannon entropy of a label sequence with nltk; written for
# Python 2. Running the file executes its doctests and prints an example.
# test_entropy.py imports it.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python entropy.py
#
# Requirements:
# - Python 2, whose print statement the source uses
# - NLTK
#

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
