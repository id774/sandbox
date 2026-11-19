# birthwt.R: Regression on the birthwt data set
#
# Description:
# Write the MASS birthwt data set to birthwt.csv, read it back, convert the
# mother's weight to kilograms, and fit a logistic regression of low birth
# weight on selected columns.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript birthwt.R
#
# Requirements:
# - R with the MASS package
#

library(MASS)
head(birthwt)
write.csv(birthwt, "birthwt.csv",
          quote=TRUE, row.names=TRUE, sep=",")

data <- read.csv("birthwt.csv",
                 header=TRUE, skip=0)
head(data)

sample <- birthwt[,c(1,2,3,5,6,7,8)]
sample$lwt <- sample$lwt * 0.454
str(sample)
head(sample)

attach(sample)
result <- glm(low~., family=binomial, data=sample)
summary(result)
