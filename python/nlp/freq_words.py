#!/usr/bin/env python
# - * - coding: utf-8 - * -

import nltk
import sys
import re, pprint

def pp(obj):
    pp = pprint.PrettyPrinter(indent=4,width=160)
    str = pp.pformat(obj)
    return re.sub(r"\\u([0-9a-f]{4})",lambda x:unichr(int("0x"+x.group(1),16)),str)

def freq_words(url):
    freqdist = nltk.FreqDist()
    text = nltk.clean_url(url)
    for word in nltk.word_tokenize(text):
        freqdist.inc(word.lower())
    return freqdist

def main():
    constitution = (sys.argv[1])
    fd = freq_words(constitution)
    for key in fd.keys()[:20]: print pp(key)

if __name__=='__main__':
    main()

