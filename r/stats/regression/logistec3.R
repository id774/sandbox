# logistec3.R: Linear and logistic models of R
#
# Description:
# Sort sample_data.csv by A and fit linear and logistic models of R on L, A,
# FR, and TIME.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript logistec3.R
#
# Requirements:
# - R
# - sample_data.csv in the current directory
#

data1 <- read.csv("sample_data.csv", header=TRUE)
data1
sortlist <- order(data1$A)
data2 <- data1[sortlist,]
rownames(data2) <- c(1:nrow(data2))
mydata = lm(R ~ L + A + FR + TIME, data=data2)
summary(mydata)
mylogit = glm(R ~ L + A + FR + TIME, data=data2, family=binomial(link="logit"))
summary(mylogit)
confint(mylogit)
confint.default(mylogit)
fitted(mylogit)

exp(mylogit[[1]])
fit = fitted(mylogit)
fit
png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(data2$A, fit, col="red")
par(new=TRUE)
plot(data2$A, data2$R)
dev.off()
