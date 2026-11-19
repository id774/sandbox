# main.py: Main class entry point with argument and version checks
#
# Description:
# Provide a main class entry point guarded by argument count and version
# checks. It prints the first two arguments and the number of command line
# arguments.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 main.py <arg1> <arg2>
#
# Requirements:
# - Python 3, which the program checks before running
#

import sys

class MainClass:

    def __init__(self, args):
        self.args1 = args[1]
        self.args2 = args[2]

    def main(self):
        print(self.args1)
        print(self.args2)
        print(len(sys.argv))
        return 0

if __name__ == '__main__':
    argsmin = 2
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            main_instance = MainClass(sys.argv)
            sys.exit(main_instance.main())
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
