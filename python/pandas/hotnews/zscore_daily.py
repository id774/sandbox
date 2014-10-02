import sys
import datetime
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

def main(args):
    try:
        yyyymmdd = args.pop(1)
        if yyyymmdd == "today":
            yyyymmdd = datetime.date.today().strftime('%Y%m%d')
    except IndexError:
        d = datetime.date.today() - datetime.timedelta(days=1)
        yyyymmdd = d.strftime('%Y%m%d')

    filename = "/home/fluent/.fluent/log/hotnews_" + yyyymmdd + ".txt"
    add_zcore(filename)

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
