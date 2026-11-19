# args_pop.py: Shift command line arguments off a list subclass
#
# Description:
# Shift command line arguments off a list subclass, defaulting a date to
# yesterday. The program prints the command name, the date argument in
# YYYYMMDD form (yesterday when omitted), and up to three further arguments,
# printing None for each missing one.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 args_pop.py [YYYYMMDD] [arg3] [arg4] [arg5]
#
# Requirements:
# - Python 3, which the program checks before running
#

import sys
import datetime

class List(list):
    def shift(self):
        try:
            return self.pop(0)
        except IndexError:
            return None

def main(args_arr):
    args = List(args_arr)
    cmd_name = args.shift()
    print(cmd_name)

    yyyymmdd = args.shift()
    if not yyyymmdd:
        d = datetime.date.today() - datetime.timedelta(days=1)
        yyyymmdd = d.strftime('%Y%m%d')

    print(yyyymmdd)

    args3 = args.shift()
    args4 = args.shift()
    args5 = args.shift()

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
