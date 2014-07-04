png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)

data = read.table("wine.csv")

par(mgp=c(2,0.8,0))
plot(data$WRAIN, data$LPRICE2, pch=16,
     xlab="収穫前年の10月〜3月の雨量",
     ylab="ワインの価格")

cor.test(data$WRAIN, data$LPRICE2)
data1 = subset(data, LPRICE2 < 0)
cor.test(data1$WRAIN, data1$LPRICE2)

