
library(ggplot2)
library(maps)

# 緯度経度
map(xlim=c(121, 155), ylim=c(20, 50))

# データ取り込み
bst <- readLines('http://www.jma.go.jp/jma/jma-eng/jma-center/rsmc-hp-pub-eg/Besttracks/bst2013.txt')

# ヘッダー（はじめが 66666 ）を抜き出す
header <- read.table(textConnection(bst[grep("^66666", bst)]))

# レコード部分（それ以外）を抜き出す
record<-read.table(textConnection(bst[-grep("^66666", bst)]),fill=TRUE)

# 行の長さが違うので、入らないところカット
record<-record[!is.na(record[,7]),]

# 必要なところを採ってくる
header<-header[ , c(3,4,8)]
names(header) <- c("NROW", "TC_NO", "NAME")
record<-record[ , c(1,3:7)]
names(record) <- c("DATE_TIME", "GRADE", "LAT", "LON", "HPA", "KT")

# 台風の識別番号をつける
record$TC_NO <- rep(header$TC_NO, header$NROW)

# 台風の識別番号をもとに結合
data <- merge(header, record, by = "TC_NO")

# 元データが 10 倍されているので、値変換 transform
data <- transform(data, LAT = LAT / 10, LON = LON / 10)
# ここまでで、データ処理終わり、あとはビジュアライゼーション

# 範囲確認
range_lon<-range(data$LON)
range_lat<-range(data$LAT)
range_lon
range_lat

# 座標パス XY だけを取得
map<-data.frame(map(plot=FALSE,
xlim=c(range_lon[1]-10, range_lon[2]+10),
ylim=c(range_lat[1]-5, range_lat[2]+5))[c("x","y")])

# 描画（大きさで太さが変わる）
ggplot(data, aes(LON, LAT, colour = NAME)) +
geom_point(aes(size = GRADE)) +
geom_path(aes(x, y, colour = NULL), map)

# 軌道っぽくする（透明度を上げて見えるように）
ggplot(data, aes(LON, LAT, colour = NAME)) +
geom_point(aes(size = GRADE), shape = 1, alpha = 0.5) +
geom_path() +
geom_path(aes(x, y, colour = NULL), map)

# 画像で保存 ggsave
p <- ggplot(data, aes(LON, LAT, colour = NAME)) +
geom_point(aes(size = GRADE)) +
geom_path(aes(x, y, colour = NULL), map)
ggsave("image.png",p)

