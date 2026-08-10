#region = c("Hokkaidou","Honshu","Shikoku","Kyushu","Okinawa")
region = c("北海道","本州","四国","九州","沖縄")
png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
area = c(83457,231113,18792,42191,2276) / 10000

par(las=1)              # 縦軸の文字を横向きにしない（las: label style）
par(mgp=c(2,0.8,0))     # 軸マージン（デフォルト: c(3,1,0)）
barplot(area, names.arg=region, ylab="面積（万km^2）")
axis(2, labels=expression(paste("面積（万", km^2, "）")),
     at=20, hadj=0.3, padj=-1, tick=FALSE)
dev.off()
