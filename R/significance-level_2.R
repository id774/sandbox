# 施行回数 N=40
# 成功回数 x=0:N
# 成功確率 p=1/6
# 有意水準 α=0.1

p <- dbinom(x=0:40, size=40, prob=1/6)
plot(x=0:40, p, type="l")
qbinom(0.1, size=40, prob=1/6, lower.tail=FALSE)

abline(v=qbinom(0.1, size=40, prob=1/6, lower.tail=FALSE), col="red")

