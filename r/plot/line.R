
readdata <- function(name) {
  read.csv(paste(name, "csv", sep="."),
           header=TRUE, skip=0)
}

savedata <- function(name, data) {
  write.csv(data, paste(name, "csv", sep="."),
            quote=TRUE, row.names=FALSE, sep=",")
}

draw <- function(name, data) {
  png(name, width = 480, height = 480, pointsize = 12, bg = "white", res = NA)

  par(las=1)              # 縦軸の文字を横向きにしない
  par(mgp=c(2,0.8,0))     # 軸マージン（デフォルト: c(3,1,0)）

  気温 = data
  年 = 1891:2009

  plot(年, 気温, type="o", pch=16, xlab="", ylab="", xaxt="n")
  t = c(1891, seq(1900,2000,20), 2009)
  axis(1, t, t)
  axis(4, labels=FALSE)
  title("地球の平均気温の変化（単位：℃，相対値）", line=0.5)

  res = lm(気温 ~ 年)
  summary(res)
  abline(res)

  dev.off()
}

data <- readdata("line")
data <- data[,c(1)]

savedata("line", data)

draw("image.png", data)

