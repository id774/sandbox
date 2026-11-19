# read_all_files.py: First rows of every text file in a directory
#
# Description:
# Read the first row of every text file under a directory into a dict.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 read_all_files.py <directory>
#
# Requirements:
# - Python 3, which the program checks before running
# - pandas before 1.0, which still provides DataFrame.ix
#

import sys
import os
import pandas as pd

def read_file(filename):
    df = pd.read_csv(filename, header=None)
    return df.ix[0].tolist()

def read_all_files(path):
    dic = {}
    for root, dirs, files in os.walk(path):
        for filename in files:
            if filename.endswith("txt"):
                fullname = os.path.join(root, filename)
                print("Parse: " + filename)
                dic[filename] = read_file(fullname)
    return dic

def main(args):
    path = args[1]
    dic = read_all_files(path)
    print(dic)

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
