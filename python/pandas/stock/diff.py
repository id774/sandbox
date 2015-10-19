import sys
import numpy as np
import pandas as pd

def calc_pred_ratio(df):
    l = len(df)
    result = np.zeros(l, dtype=float)
    for i in range(l):
        result[i] = (df['Pred'][i] / df['Close'][i] * 100) - 100
    return result

def calc_trend_correct(df):
    l = len(df)
    result = np.zeros(l, dtype=int)
    for i in range(l):
        if df['Prev'][i] > df['Close'][i] and df['Trend'][i] == 0:
            result[i] = 1
        if df['Prev'][i] <= df['Close'][i] and df['Trend'][i] == 1:
            result[i] = 1
    return result

def calc_correct(df):
    l = len(df)
    result = np.zeros(l, dtype=int)
    for i in range(l):
        if df['Pred-D'][i] == 1 and df['Errata-D'][i] == 1:
            result[i] = 1
        if df['Pred-U'][i] == 1 and df['Errata-U'][i] == 1:
            result[i] = 1
    return result

def calc_errata_u(df):
    l = len(df)
    result = np.zeros(l, dtype=int)
    for i in range(l):
        if df['Prev'][i] <= df['Close'][i] and df['Pred-U'][i] == 1:
            result[i] = 1
    return result

def calc_errata_d(df):
    l = len(df)
    result = np.zeros(l, dtype=int)
    for i in range(l):
        if df['Prev'][i] > df['Close'][i] and df['Pred-D'][i] == 1:
            result[i] = 1
    return result

def calc_pred_u(df):
    l = len(df)
    result = np.zeros(l, dtype=int)
    for i in range(l):
        if df['Prev'][i] <= df['Pred'][i] and df['Trend'][i] == 1:
            result[i] = 1
    return result

def calc_pred_d(df):
    l = len(df)
    result = np.zeros(l, dtype=int)
    for i in range(l):
        if df['Prev'][i] > df['Pred'][i] and df['Trend'][i] == 0:
            result[i] = 1
    return result

def main(args):
    infile1 = "".join(["summary.csv.", args[1], ".csv"])
    infile2 = "".join(["summary.csv.", args[2], ".csv"])
    outfile = "".join(["diff_", args[1], "-", args[2], ".csv"])

    sortkey = 'Code'
    df1 = pd.read_csv(infile1, sep='\t').sort(sortkey, ascending=True)
    df2 = pd.read_csv(infile2, sep='\t').sort(sortkey, ascending=True)
    df3 = pd.merge(df1, df2, on='Code')
    df = pd.DataFrame([df3.ix[:, 'Code'],
                       df3.ix[:, 'Close_x'],
                       df3.ix[:, 'Trend_x'],
                       df3.ix[:, 'Pred_x'],
                       df3.ix[:, 'Close_y']], index=['Code',
                                                     'Prev',
                                                     'Trend',
                                                     'Pred',
                                                     'Close']).T
    df['Pred-D'] = calc_pred_d(df)
    df['Pred-U'] = calc_pred_u(df)
    df['Errata-D'] = calc_errata_d(df)
    df['Errata-U'] = calc_errata_u(df)
    df['Correct'] = calc_correct(df)
    df['Trend-Correct'] = calc_trend_correct(df)
    df['Pred-Ratio'] = calc_pred_ratio(df)

    df.ix[-1, 'Code'] = "Total"
    pred_d = df['Pred-D'].sum()
    pred_u = df['Pred-U'].sum()
    errata_d = df['Errata-D'].sum()
    errata_u = df['Errata-U'].sum()
    correct = df['Correct'].sum()
    trend_correct = df['Trend-Correct'].sum()
    pred_mean = df['Pred-Ratio'].mean()
    pred_max = df['Pred-Ratio'].max()
    pred_min = df['Pred-Ratio'].min()
    df.ix[-1, 'Pred-D'] = pred_d
    df.ix[-1, 'Pred-U'] = pred_u
    df.ix[-1, 'Errata-D'] = errata_d
    df.ix[-1, 'Errata-U'] = errata_u
    trend_ratio = df['Trend'].sum()
    df.ix[-1, 'Trend-Ratio'] = trend_ratio
    df.ix[-1, 'Trend-Correct'] = trend_correct
    trend_correct_ratio = trend_correct / len(df) * 100
    df.ix[-1, 'Trend-Correct-Ratio'] = trend_correct_ratio
    df.ix[-1, 'Correct'] = correct
    total = correct / (pred_d + pred_u) * 100
    df.ix[-1, 'Total-Correct-Ratio'] = total
    df.ix[-1, 'Predict-mean'] = pred_mean
    df.ix[-1, 'Predict-max'] = pred_max
    df.ix[-1, 'Predict-min'] = pred_min

    print(df.ix[-1, :])

    df.to_csv(outfile, index=False)

    return df

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
