#!/usr/bin/env python
# - * - coding: utf-8 - * -
# freq_words.py: Most frequent words on a web page with nltk
#
# Description:
# Report the most frequent words on a web page with nltk; written for Python
# 2. The URL is given as the first argument.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python freq_words.py <URL>
#
# Requirements:
# - Python 2, whose print statement the source uses
# - NLTK
#

import nltk
import sys
import re
import pprint

def pp(obj):
    pp = pprint.PrettyPrinter(indent=4, width=160)
    str = pp.pformat(obj)
    return re.sub(r"\\u([0-9a-f]{4})", lambda x: unichr(int("0x" + x.group(1), 16)), str)

def freq_words(url):
    freqdist = nltk.FreqDist()
    text = nltk.clean_url(url)
    for word in nltk.word_tokenize(text):
        freqdist.inc(word.lower())
    return freqdist

def main():
    constitution = (sys.argv[1])
    fd = freq_words(constitution)
    for key in fd.keys()[:20]:
        print pp(key)

if __name__ == '__main__':
    main()
