
dataflame <- read.table("~/etc/category_map.txt", sep="\t")

words <- dataflame$V1
hits <- dataflame$V2

social        <- dataflame$V3
politics      <- dataflame$V4
international <- dataflame$V5
economics     <- dataflame$V6
electro       <- dataflame$V7
sports        <- dataflame$V8
entertainment <- dataflame$V8
science       <- dataflame$V9

# 社会と政治の散布図
png("social-politics.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(social, politics)
dev.off()

# 以下略
png("politics-international.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(politics, international)
dev.off()

png("international-economics.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(international, economics)
dev.off()

