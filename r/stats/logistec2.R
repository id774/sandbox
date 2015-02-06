## mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
data1 <- read.csv("data1.csv", header=TRUE)
data1
sortlist <- order(data1$x2)
data2 <- data1[sortlist,]
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
