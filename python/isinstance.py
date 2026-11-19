#!/usr/bin/env python
# - * - coding: utf-8 - * -
# isinstance.py: Guard a function argument with isinstance
#
# Description:
# Guard a function with isinstance and report the assertion failure.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 isinstance.py
#
# Requirements:
# - Python 3
#

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
