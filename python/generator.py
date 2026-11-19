# generator.py: Take values from a generator with next()
#
# Description:
# Pull successive values from a generator with next().
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 generator.py
#
# Requirements:
# - Python 3
#

def my_generator():
    yield 10
    yield 20
    yield 30

def main():
    gen = my_generator()
    print(next(gen))
    print(next(gen))
    print(next(gen))

main()
