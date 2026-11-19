# pca_example.R: Principal component biplot of USArrests
#
# Description:
# Run princomp on the USArrests data set with the correlation matrix and write
# a biplot to image.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript pca_example.R
#
# Requirements:
# - R
#

data(USArrests)
pc.cr<-princomp(USArrests,cor=T)
png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
biplot(pc.cr)
dev.off()
