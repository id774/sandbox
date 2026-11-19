# svm.R: Support vector machine on iris with e1071
#
# Description:
# Train support vector machines on the iris data set with e1071 and print the
# models and predictions.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript svm.R
#
# Requirements:
# - R with the e1071 package
#

library("e1071")

data(iris)
attach(iris)

model <- svm(Species ~ ., data = iris)
x <- subset(iris, select = -Species)
y <- Species

model <- svm(x, y)
print(model)
summary(model)

pred <- predict(model, x)
pred <- fitted(model)

table(pred, y)

pred <- predict(model, x, decision.values = TRUE)

attr(pred, "decision.values")[1:4,]
png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(cmdscale(dist(iris[,-5])),
     col = as.integer(iris[,5]),
     pch = c("o","+")[1:150 %in% model$index + 1])
dev.off()
