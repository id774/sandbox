# multi_regression.R: Multiple regression of a CSV column
#
# Description:
# Read sample_data.csv, use its first column as row names, and regress the
# third remaining column on the first two.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript multi_regression.R
#
# Requirements:
# - R
# - sample_data.csv in the current directory
#

df = read.csv("sample_data.csv")

row.names(df) = df[,1]
df = df[,2:4]
head(df)

a <- df[,1]
b <- df[,2]
y <- df[,3]

result = lm(y ~ a + b)
summary(result)
