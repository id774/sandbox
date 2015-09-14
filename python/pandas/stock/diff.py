import sys
import pandas as pd

def main(args):
    file1 = args[1]
    file2 = args[2]
    file3 = args[3]

    sortkey = 'Code'
    df1 = pd.read_csv(file1, sep='\t').sort(sortkey, ascending=True)
    df2 = pd.read_csv(file2, sep='\t').sort(sortkey, ascending=True)
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
    df4.to_csv(file3)

if __name__ == '__main__':
    argsmin = 3
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
