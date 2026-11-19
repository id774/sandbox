# logistec2.R: Linear and logistic models of a sorted data set
#
# Description:
# Sort data1.csv by x2 and fit linear and logistic models of y on x1 and x2.
# The commented line below is an unused data source.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript logistec2.R
#
# Requirements:
# - R
# - data1.csv in the current directory
#

## mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
data1 <- read.csv("data1.csv", header=TRUE)
data1
sortlist <- order(data1$x2)
data2 <- data1[sortlist,]
rownames(data2) <- c(1:nrow(data2))
mydata = lm(y ~ x1 + x2, data=data2)
summary(mydata)
mylogit = glm(y ~ x1 + x2, data=data2, family=binomial(link="logit"))
summary(mylogit)
confint(mylogit)
confint.default(mylogit)

exp(mylogit[[1]])
fit = fitted(mylogit)
fit
png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(data2$x2, fit)
dev.off()
