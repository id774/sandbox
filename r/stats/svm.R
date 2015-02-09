
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
