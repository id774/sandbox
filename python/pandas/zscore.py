import sys
import pandas as pd
from scipy import stats

def calc_zscore(df):
    zscore = stats.zscore(df.ix[:,1])
    df[5] = zscore
    return df

def add_zcore(filename):
    df = pd.read_table(filename, header=None)
    scored_df = calc_zscore(df)
    scored_df.to_csv(filename, header=None, index=None, sep="\t")

def main(args):
    filename = args[1]
    add_zcore(filename)

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
