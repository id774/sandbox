
# http://blog.yhathq.com/posts/logistic-regression-and-python.html

import pandas as pd
import statsmodels.api as sm
import pylab as pl
import numpy as np

# read the data in
df = pd.read_csv("http://www.ats.ucla.edu/stat/data/binary.csv")

# take a look at the dataset
print((df.head()))
#    admit  gre   gpa  rank
# 0      0  380  3.61     3
# 1      1  660  3.67     3
# 2      1  800  4.00     1
# 3      1  640  3.19     4
# 4      0  520  2.93     4

# rename the 'rank' column because there is also a DataFrame method called
# 'rank'
df.columns = ["admit", "gre", "gpa", "prestige"]
print((df.columns))
# array([admit, gre, gpa, prestige], dtype=object)

# dummify rank
dummy_ranks = pd.get_dummies(df['prestige'], prefix='prestige')
print(dummy_ranks.head())
#    prestige_1  prestige_2  prestige_3  prestige_4
# 0           0           0           1           0
# 1           0           0           1           0
# 2           1           0           0           0
# 3           0           0           0           1
# 4           0           0           0           1

# create a clean data frame for the regression
cols_to_keep = ['admit', 'gre', 'gpa']
data = df[cols_to_keep].join(dummy_ranks.ix[:, 'prestige_2':])
print(data.head())
#    admit  gre   gpa  prestige_2  prestige_3  prestige_4
# 0      0  380  3.61           0           1           0
# 1      1  660  3.67           0           1           0
# 2      1  800  4.00           0           0           0
# 3      1  640  3.19           0           0           1
# 4      0  520  2.93           0           0           1

# manually add the intercept
data['intercept'] = 1.0

train_cols = data.columns[1:]
# Index([gre, gpa, prestige_2, prestige_3, prestige_4], dtype=object)

logit = sm.Logit(data['admit'], data[train_cols])

# fit the model
result = logit.fit()

# cool enough to deserve it's own gist
print(result.summary())

# look at the confidence interval of each coeffecient
print(result.conf_int())
#                    0         1
# gre         0.000120  0.004409
# gpa         0.153684  1.454391
# prestige_2 -1.295751 -0.055135
# prestige_3 -2.016992 -0.663416
# prestige_4 -2.370399 -0.732529
# intercept  -6.224242 -1.755716
