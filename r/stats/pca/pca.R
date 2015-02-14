chu = read.csv("atest2014chu.csv",
               fileEncoding="CP932")
sho = read.csv("atest2014sho.csv",
               fileEncoding="CP932")
row.names(chu) = chu[,1]
chu = chu[,2:5]
head(chu)
result <- prcomp(chu, scale=TRUE)
summary(result)

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(xpd=TRUE)
biplot(result)
dev.off()

row.names(sho) = sho[,1]
sho = sho[,2:5]
result <- prcomp(sho, scale=TRUE)
summary(result)

png("image2.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(xpd=TRUE)
biplot(result)
dev.off()

all = data.frame(sho, chu)
names(all) = c("小国A","小国B","小算A","小算B","中国A","中国B","中数A","中数B")
cor(all)
result = factanal(all, factors=2, scores="regression")
summary(result)

png("image3.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
par(xpd=TRUE)
biplot(result$scores, result$loadings)
dev.off()
