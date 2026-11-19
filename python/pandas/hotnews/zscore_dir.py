# zscore_dir.py: Add z score columns to every log file in a directory
#
# Description:
# Add a z score column to every log file under the directory given as an
# argument, rewriting each file.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 zscore_dir.py <directory>
#
# Requirements:
# - Python 3, which the program checks before running
# - SciPy
# - pandas before 1.0, which still provides DataFrame.ix
#

import sys
import os
import pandas as pd
from scipy import stats

def calc_zscore(df, name):
    try:
        zscore = stats.zscore(df.ix[:, 1])
        df[5] = zscore
    except TypeError:
        print("TypeError: " + name)
    return df

def add_zcore(filename):
    try:
        df = pd.read_table(filename, header=None)
        df[2] = [x.replace("\t", "") for x in df[2]]
        scored_df = calc_zscore(df, filename)
        scored_df.to_csv(filename, header=None, index=None, sep="\t")
    except pd.parser.CParserError:
        print("ParseError: " + filename)

def list_files(path):
    for root, dirs, files in os.walk(path):
        for filename in files:
            if filename.startswith("hotnews_2013"):
                fullname = os.path.join(root, filename)
                print("Parse: " + filename)
                add_zcore(fullname)

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
