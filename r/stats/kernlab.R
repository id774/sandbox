# kernlab.R: Support vector machine on two iris species with kernlab
#
# Description:
# Train ksvm on the petal measurements of two iris species and plot the model
# to image.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript kernlab.R
#
# Requirements:
# - R with the kernlab package
#

library(kernlab)

data(iris)
attach(iris)

y<-as.matrix(iris[51:150,5])
iris1<-data.frame(iris[51:150,3:4],y)

set.seed(0)
ir.ksvm<-ksvm(y~.,data=iris1)

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(ir.ksvm,data=iris1[,1:2])
dev.off()
