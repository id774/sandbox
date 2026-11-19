# sysexit.py: Return a fixed exit code through sys.exit
#
# Description:
# Return a fixed exit code through sys.exit from main. The program prints its
# first argument and always exits with status 1.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 sysexit.py <argument>
#
# Requirements:
# - Python 3, which the program checks before running
#

import sys

def main(args):
    print("arg1 is %s" % args[1])
    return 1  # This program always return code 1.

if __name__ == '__main__':
    argsmin = 1
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
