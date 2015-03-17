library(MASS)
head(birthwt)
write.table(birthwt, "birthwt.csv", sep=",")

data <- read.csv("birthwt.csv", header=TRUE)
head(data)

sample <- birthwt[,c(1,2,3,5,6,7,8)]
sample$lwt <- sample$lwt * 0.454
str(sample)
head(sample)

attach(sample)
result <- glm(low~., family=binomial, data=sample)
summary(result)
