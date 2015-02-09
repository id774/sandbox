library(kernlab)

data(iris)
attach(iris)

y<-as.matrix(iris[51:150,5])
iris1<-data.frame(iris[51:150,3:4],y)

set.seed(0)
ir.ksvm<-ksvm(y~.,data=iris1)

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(ir.ksvm,data=iris1[,1:2])
dev.off()
