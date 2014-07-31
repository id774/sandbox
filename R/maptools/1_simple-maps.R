library(gpclib)
library(maptools)     # loads sp library too
library(RColorBrewer) # creates nice color schemes
library(classInt)     # finds class intervals for continuous variables

gpclibPermit()

# outlines of Oregon counties (lines)
# browse to orotl.shp
orotl.shp <- readShapeLines('orotl.shp',
    proj4string=CRS("+proj=longlat"))

# Oregon climate station data (points)
# browse to orstations.shp
orstations.shp <- readShapePoints('orstations.shp',
    proj4string=CRS("+proj=longlat"))

# Oregon county census data (polygons)
# browse to orcounty.shp
orcounty.shp <- readShapePoly('orcounty.shp',
    proj4string=CRS("+proj=longlat"))

# Read CSV
orstationc <- read.csv("orstationc.csv")
orcountyp <- read.csv("orcountyp.csv")
cities <- read.csv("cities2.csv")

# View Data
summary(orcounty.shp)
attributes(orcounty.shp)
attributes(orcounty.shp@data)
attr(orcounty.shp,"polygons")

# Empty plot
png("image0-1.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(orotl.shp, xlim=c(-124.5, -115), ylim=c(42,47))
dev.off()
png("image0-2.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(orcounty.shp, xlim=c(-124.5, -115), ylim=c(42,47))
dev.off()
png("image0-3.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plot(orstations.shp, xlim=c(-124.5, -115), ylim=c(42,47))
dev.off()

# Oregon county census data -- attribute data in the orcounty.shp shape file
png("image1-1.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plotvar <- orcounty.shp@data$POP1990
nclr <- 8
plotclr <- brewer.pal(nclr,"BuPu")
class <- classIntervals(plotvar, nclr, style="quantile")
colcode <- findColours(class, plotclr)
plot(orcounty.shp, xlim=c(-124.5, -115), ylim=c(42,47))
plot(orcounty.shp, col=colcode, add=T)
title(main="Population 1990",
    sub="Quantile (Equal-Frequency) Class Intervals")
legend(-117, 44, legend=names(attr(colcode, "table")),
    fill=attr(colcode, "palette"), cex=0.6, bty="n")
dev.off()

# Oregon climate station data -- data in the orstationc.csv file, basemap in orotl.shp
png("image1-2.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plotvar <- orstationc$tann
nclr <- 8
plotclr <- brewer.pal(nclr,"PuOr")
plotclr <- plotclr[nclr:1] # reorder colors
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
plot(orotl.shp, xlim=c(-124.5, -115), ylim=c(42,47))
points(orstationc$lon, orstationc$lat, pch=16, col=colcode, cex=2)
points(orstationc$lon, orstationc$lat, cex=2)
title("Oregon Climate Station Data -- Annual Temperature",
    sub="Equal-Interval Class Intervals")
legend(-117, 44, legend=names(attr(colcode, "table")),
    fill=attr(colcode, "palette"), cex=0.6, bty="n")
dev.off()

# Oregon climate station data -- locations and data in shape file
png("image1-3.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plotvar <- orstations.shp@data$pann
nclr <- 5
plotclr <- brewer.pal(nclr,"BuPu")
class <- classIntervals(plotvar, nclr, style="fixed",
fixedBreaks=c(0,200,500,1000,2000,5000))
colcode <- findColours(class, plotclr)
orstations.pts <- orstations.shp@coords # get point data
plot(orotl.shp, xlim=c(-124.5, -115), ylim=c(42,47))
points(orstations.pts, pch=16, col=colcode, cex=2)
points(orstations.pts, cex=2)
title("Oregon Climate Station Data -- Annual Precipitation",
    sub="Fixed-Interval Class Intervals")
legend(-117, 44, legend=names(attr(colcode, "table")),
fill=attr(colcode, "palette"), cex=0.6, bty="n")
dev.off()

