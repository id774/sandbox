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
