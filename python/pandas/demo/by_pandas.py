# by_pandas.py: Top ten products by sales with a pandas groupby
#
# Description:
# Total the top ten products by sales with a pandas groupby.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 by_pandas.py
#
# Requirements:
# - Python 3
# - pandas
# - product.csv in the current directory
#

import pandas as pd
filename = "product.csv"
data = pd.read_csv(filename)  # header is conveniently inferred by default
top10 = data.groupby("Product")["ItemsSold"].sum().order(ascending=False)[:10]
print(top10)
