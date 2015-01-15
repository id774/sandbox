
library(XML)
library(RCurl)
library(RgoogleMaps)
#library(ReadImages)

source("ggmap3.R")

address <- data.frame(addr=c("東京都港区六本木6-10-1",
                             "東京都港区赤坂九丁目7番1号",
                             "東京都渋谷区代々木四丁目30番3号",
                             "東京都千代田区霞が関1-1-1" ),
                        stringsAsFactors = FALSE )

image <- c('image.png')
png(image, width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
map <- ggmap3(locationdata=address, mapname=image, num=1)
#PlotOnStaticMap(map)
dev.off()
