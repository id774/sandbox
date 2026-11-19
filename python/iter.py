# iter.py: Implement the iterator protocol
#
# Description:
# Implement the iterator protocol with __iter__ and __next__.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 iter.py
#
# Requirements:
# - Python 3
#

class MyIterator(object):
    def __init__(self, *numbers):
        self._numbers = numbers
        self._i = 0

    def __iter__(self):
        return self

    def __next__(self):
        if self._i == len(self._numbers):
            raise StopIteration()
        value = self._numbers[self._i]
        self._i += 1
        return value

def main():
    my_iterator = MyIterator(10, 20, 30)
    for num in my_iterator:
        print(num)

main()
