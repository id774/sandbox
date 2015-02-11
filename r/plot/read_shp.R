library(gpclib)
library(maptools)
library(RColorBrewer)

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
pict <- readShapePoly("1.shp")
plot(pict)
dev.off()

