# args_pop2.py: Shift command line arguments with an imported List class
#
# Description:
# Shift command line arguments using the List subclass imported from
# list_shift, and print up to four arguments after the command name.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 args_pop2.py [arg2] [arg3] [arg4] [arg5]
#
# Requirements:
# - Python 3, which the program checks before running
# - A list_shift module that provides the List class; it is not included in
#   this repository
#

import sys
from list_shift import List

def main(args_arr):
    args = List(args_arr)
    args.shift()

    args2 = args.shift()
    args3 = args.shift()
    args4 = args.shift()
    args5 = args.shift()

    print(args2)
    print(args3)
    print(args4)
    print(args5)

if __name__ == '__main__':
    argsmin = 0
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
