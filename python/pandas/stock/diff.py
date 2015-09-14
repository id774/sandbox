import sys
import pandas as pd

def main(args):
    infile1 = "".join(["summary_", args[1], ".csv"])
    infile2 = "".join(["summary_", args[2], ".csv"])
    outfile = "".join(["diff_", args[1], "-", args[2], ".csv"])

    sortkey = 'Code'
    df1 = pd.read_csv(infile1, sep='\t').sort(sortkey, ascending=True)
    df2 = pd.read_csv(infile2, sep='\t').sort(sortkey, ascending=True)
    df3 = pd.merge(df1, df2, on='Code')
    df4 = pd.DataFrame([df3.ix[:, 'Code'],
                        df3.ix[:, 'Close_x'],
                        df3.ix[:, 'Trend_x'],
                        df3.ix[:, 'Pred_x'],
                        df3.ix[:, 'Close_y']], index=['Code',
                                                      'Prev',
                                                      'Trend',
                                                      'Pred',
                                                      'Close']).T
    df4.to_csv(outfile, index=False)

if __name__ == '__main__':
    argsmin = 2
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
