# zscore_check.py: Check log files for a parsable z score column
#
# Description:
# Check every log file under a directory for a parsable z score column.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 zscore_check.py <directory>
#
# Requirements:
# - Python 3, which the program checks before running
# - pandas
#

import sys
import os
import pandas as pd

def check_zcore(filename):
    try:
        df = pd.read_table(filename, header=None)
        df[5].describe()
    except (pd.parser.CParserError, KeyError):
        print("ParseError: " + filename)

def list_files(path):
    for root, dirs, files in os.walk(path):
        for filename in files:
            if filename.startswith("hotnews"):
                fullname = os.path.join(root, filename)
                print("Check: " + filename)
                check_zcore(fullname)

def main(args):
    path = args[1]
    list_files(path)

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
