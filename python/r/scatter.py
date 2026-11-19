# scatter.py: Drive R from Python with pyper
#
# Description:
# Drive R from Python with pyper and read the results back as a Series. The R
# side runs scatter.R.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 scatter.py
#
# Requirements:
# - Python 3
# - PypeR and pandas
# - R
#

import pyper
import pandas as pd

wine = pd.read_csv("wine.csv")

# Create the R instance
r = pyper.R(use_pandas='True')

# Pass the data from Python to R
r.assign("data", wine)

# Run an R source file
r("source(file='scatter.R')")

# Run R code directly
r("res1 = cor.test(data$WRAIN, data$LPRICE2)")
r("data1 = subset(data, LPRICE2 < 0)")
r("res2 = cor.test(data1$WRAIN, data1$LPRICE2)")

# Read the R objects back in Python
res1 = pd.Series(r.get("res1"))
print(res1)
res2 = pd.Series(r.get("res2"))
print(res2)
