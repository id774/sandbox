# literal.py: Print a regular expression tree with precedence brackets
#
# Description:
# Print a regular expression tree, bracketing subpatterns by precedence.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 literal.py
#
# Requirements:
# - Python 3
#

class Pattern:

    def __init__(self, precedence):
        self.precedence = precedence

    def bracket(self, outer_precedence):
        if self.precedence < outer_precedence:
            return '({0})'.format(self)
        return str(self)

    def __repr__(self):
        return '/{0}/'.format(self)


class Empty(Pattern):

    def __init__(self):
        Pattern.__init__(self, 3)

    def __str__(self):
        return ''


class Literal(Pattern):

    def __init__(self, character):
        Pattern.__init__(self, 3)
        self.character = character

    def __str__(self):
        return self.character


class Concatenate(Pattern):

    def __init__(self, first, second):
        Pattern.__init__(self, 1)
        self.first = first
        self.second = second

    def __str__(self):
        return ''.join(map(lambda pattern: pattern.bracket(pattern.precedence),
                           (self.first, self.second)))


class Choose(Pattern):

    def __init__(self, first, second):
        Pattern.__init__(self, 0)
        self.first = first
        self.second = second

    def __str__(self):
        return '|'.join(map(
            lambda pattern: pattern.bracket(pattern.precedence),
            (self.first, self.second)))


class Repeat(Pattern):

    def __init__(self, pattern):
        Pattern.__init__(self, 2)
        self.pattern = pattern

    def __str__(self):
        return self.pattern.bracket(pattern.precedence) + '*'

if __name__ == '__main__':
    pattern = Repeat(Choose(Concatenate(Literal('a'),
                                        Literal('b')),
                            Literal('a')))
    print(pattern)
    print(repr(pattern))
