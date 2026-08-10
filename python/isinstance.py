#!/usr/bin/env python
# - * - coding: utf-8 - * -
# Guard a function with isinstance and report the assertion failure.

def tag(word):
    try:
        assert isinstance(word, str)
        if word in ['a', 'the', 'all']:
            return 'det'
        else:
            return 'none'
    except AssertionError:
        return "argument to tag() must be a string"

def main():
    print(tag('the'))
    print(tag('knight'))
    print(tag(['but', 'a', 'branch']))

if __name__ == '__main__':
    main()
