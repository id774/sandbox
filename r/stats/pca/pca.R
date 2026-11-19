# pca.R: Principal component analysis of test score data
#
# Description:
# Read atest2014chu.csv and atest2014sho.csv in CP932, run principal component
# analyses, and write biplots to image.png through image3.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript pca.R
#
# Requirements:
# - R
# - atest2014chu.csv and atest2014sho.csv in the current directory
#

chu = read.csv("atest2014chu.csv",
               fileEncoding="CP932")
sho = read.csv("atest2014sho.csv",
               fileEncoding="CP932")
row.names(chu) = chu[,1]
chu = chu[,2:5]
head(chu)
result <- prcomp(chu, scale=TRUE)
result

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(xpd=TRUE)
biplot(result)
dev.off()

row.names(sho) = sho[,1]
sho = sho[,2:5]
result <- prcomp(sho, scale=TRUE)
result

png("image2.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(xpd=TRUE)
biplot(result)
dev.off()

all = data.frame(sho, chu)
names(all) = c("小国A","小国B","小算A","小算B","中国A","中国B","中数A","中数B")
cor(all)
result = factanal(all, factors=2, scores="regression")
result

png("image3.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(xpd=TRUE)
biplot(result$scores, result$loadings)
dev.off()
