chu = read.csv("atest2014chu.csv",
               fileEncoding="CP932")
sho = read.csv("atest2014sho.csv",
               fileEncoding="CP932")
row.names(chu) = chu[,1]
chu = chu[,2:5]
head(chu)
png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(xpd=TRUE)
biplot(prcomp(chu, scale=TRUE))
dev.off()

row.names(sho) = sho[,1]
sho = sho[,2:5]
png("image2.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(xpd=TRUE)
biplot(prcomp(sho, scale=TRUE))
dev.off()

all = data.frame(sho, chu)
names(all) = c("小国A","小国B","小算A","小算B","中国A","中国B","中数A","中数B")
cor(all)
r = factanal(all, factors=2, scores="regression")
png("image3.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(xpd=TRUE)
biplot(r$scores, r$loadings)
dev.off()
