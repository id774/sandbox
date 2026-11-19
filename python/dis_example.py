# dis_example.py: Disassemble a list comprehension and a generator expression
#
# Description:
# Disassemble a list comprehension and a generator expression for comparison.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 dis_example.py
#
# Requirements:
# - Python 3
#

from dis import dis

def list_comprehensions(i=10):
    power_list = [n ** 2 for n in range(i)]
    return power_list

def generator(i=10):
    power_gen = (n ** 2 for n in range(i))
    return power_gen

print(list_comprehensions())
dis(list_comprehensions)

for n in generator():
    print(n)
dis(generator)
