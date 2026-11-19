# fa.R: Principal component biplot of sample data
#
# Description:
# Read sample_data.csv, use its first column as row names, and draw a biplot
# of the principal components of seven columns to image.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript fa.R
#
# Requirements:
# - R
# - sample_data.csv in the current directory
#

df = read.csv("sample_data.csv")

row.names(df) = df[,1]
df = df[,2:8]
head(df)

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(xpd=TRUE)
biplot(prcomp(df, scale=TRUE))
dev.off()

result <- factanal(x = df, factors = 2)
result
1 - result$uniquenesses
