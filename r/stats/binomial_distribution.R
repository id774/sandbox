# 試行回数 N=12
# 成功確率 p=1/6

x <- 0:12
p <- dbinom(0:12, size=12, prob=1/6)

sum(x * p)

barplot(p)
axis(side=1, at=barplot(p), labels=x)

