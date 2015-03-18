
# http://bio-info.biz/tips/r_boxplot.html

savedata <- function(name, data) {
  write.csv(data, paste(name, "csv", sep="."),
              quote=TRUE, row.names=FALSE, sep=",")
}

readdata <- function(name) {
  read.csv(paste(name, "csv", sep="."),
           header=TRUE, skip=0)
}

draw <- function(name, data) {
  png(name, width = 480, height = 480, pointsize = 12, bg = "white", res = NA)

  par(font.main=15, font.lab=15, font.axis=15, cex.main=3, cex.lab=1.2, cex.axis=1.2, las=1)

  boxplot(data, names=c("A", "B", "C"), col=c("#993435", "#edae00", "#539952"), main="Boxplot", xlab="Entry", ylab="Value", ylim=c(0.2, 1), width=c(1.1, 1.1, 1.1), staplewex=0.8)

  dev.off()
}

listdat <- readdata("listdat")
savedata("listdat", listdat)
listdat
draw("image.png", listdat)
