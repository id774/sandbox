data <- read.csv("sample_data.csv", header=TRUE)
data
mydata = lm(R ~ L + A + FR + TIME, data=data)
summary(mydata)
mylogit = glm(R ~ L + A + FR + TIME, data=data, family=binomial(link="logit"))
summary(mylogit)
confint(mylogit)
confint.default(mylogit)
fitted(mylogit)
