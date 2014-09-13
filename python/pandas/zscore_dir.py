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
