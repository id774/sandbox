# fermat_little_theorem.py: Fermat primality test over a range
#
# Description:
# Test primality across a range with Fermat's little theorem, from the first
# argument up to but not including the second.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 fermat_little_theorem.py <start> <end>
#
# Requirements:
# - Python 3
#

import sys

def is_prime(q):
    q = abs(q)
    if q == 2:
        return True
    if q < 2 or q & 1 == 0:
        return False
    return pow(2, q - 1, q) == 1

def main():
    for x in range(int(sys.argv[1]), int(sys.argv[2])):
        print(x, is_prime(x))

if __name__ == '__main__':
    argsmin = 2
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            main()
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
