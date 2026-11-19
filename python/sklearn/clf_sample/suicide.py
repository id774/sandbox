# suicide.py: Monthly suicide counts for three cities
#
# Description:
# Collect monthly suicide counts for three cities from the per-month CSV files
# into one frame and write suicide_2014.csv.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 suicide.py
#
# Requirements:
# - Python 3
# - Matplotlib
# - pandas before 1.0, which still provides DataFrame.ix
# - The per-month YYYYMM.csv files in the current directory
#

import matplotlib.pyplot as plt
plt.style.use('ggplot')
import pandas as pd

month = pd.date_range('1/1/2014', periods=12, freq='M')
print(month)

cities = ['Tokyo', 'Fukuoka', 'Sapporo']

total_df = pd.DataFrame([], columns=cities)

for m in month:
    df = pd.read_csv(
        m.strftime('%Y%m') + '.csv',
        index_col=0, skiprows=7, encoding='shift_jis')
    df = df.iloc[[12, 39, 0], [0, 1]]
    df.columns = ['City', 'Num']
    total_df.ix[m, :] = df['Num'].values

total_df.columns = cities
print(total_df)
total_df.to_csv('suicide_2014.csv')
