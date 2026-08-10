
time <- c(1,3,10,12,6,3,8,4,1,5)
test <- c(20,40,100,80,50,50,70,50,10,60)

jpeg(filename = "graphic.jpg", width = 480, height = 480,
    pointsize = 12, quality = 100, bg = "white", res = NA)
plot(time, test)
dev.off()

