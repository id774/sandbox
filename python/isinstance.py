#!/usr/bin/env python
# - * - coding: utf-8 - * -

import sys

def tag(word):
    try:
        assert isinstance(word, basestring)
        if word in ['a', 'the', 'all']:
            return 'det'
        else:
            return 'none'
    except AssertionError:
        return "argument to tag() must be a string"

def main():
    print tag('the')
    print tag('knight')
    print tag(['but', 'a', 'branch'])

if __name__=='__main__':
    main()

