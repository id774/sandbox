# nikkei.R: Nikkei 225 daily prices in four panels
#
# Description:
# Read nikkei_stock_average_daily_jp.csv and plot the close, open, high, and
# low series in four panels.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript nikkei.R
#
# Requirements:
# - R
# - nikkei_stock_average_daily_jp.csv in the current directory
#

nikkei225 <- read.csv('nikkei_stock_average_daily_jp.csv')
colnames(nikkei225) <- c("date","close", "open", "high", "low")
attach(nikkei225)
tail(nikkei225,10)

prices <- cbind(close, open, high, low)
par(mfrow=c(2,2), new=F)

plot(prices[, 1], type="l", xlab="データ開始日 2011/01/04 からの\n営業日経過日数", ylab="日経平均", col="blue1", main="終値")
plot(prices[, 2], type="l", xlab="データ開始日 2011/01/04 からの\n営業日経過日数", ylab="日経平均", col="deeppink1", main="始値")
plot(prices[, 3], type="l", xlab="データ開始日 2011/01/04 からの\n営業日経過日数", ylab="日経平均", col="red1", main="高値")
plot(prices[, 4], type="l", xlab="データ開始日 2011/01/04 からの\n営業日経過日数", ylab="日経平均", col="green3", main="安値")
par(mfrow=c(1,1))

png("graphic.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
dev.off()
