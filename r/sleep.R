x = with(sleep, extra[group==1])
y = with(sleep, extra[group==2])

summary(x)
summary(y)

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
boxplot(x, y)
dev.off()

t.test(x, y)

png("image2.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
cix = t.test(x)$conf.int
ciy = t.test(y)$conf.int
dotchart(c(mean(x),mean(y)), pch=16, xlim=range(c(cix,ciy)), xlab="睡眠時間の伸び（時間）")
arrows(cix[1], 1, cix[2], 1, length=0.05, angle=90, code=3)
arrows(ciy[1], 2, ciy[2], 2, length=0.05, angle=90, code=3)
mtext(c("対照群", "実験群"), side=2, at=1:2, line=0.5, las=1)
dev.off()
