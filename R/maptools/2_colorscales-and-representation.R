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
orstationc <- read.csv("orstationc.csv")
orcountyp <- read.csv("orcountyp.csv")
cities <- read.csv("cities2.csv")

# Oregon county census data -- equal-frequency class intervals
png("image2-1.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plotvar <- orcounty.shp@data$AREA
nclr <- 8
plotclr <- brewer.pal(nclr,"BuPu")
#plotclr <- plotclr[nclr:1] # reorder colors if appropriate
class <- classIntervals(plotvar, nclr, style="quantile")
colcode <- findColours(class, plotclr)
plot(orcounty.shp, xlim=c(-124.5, -115), ylim=c(42,47))
plot(orcounty.shp, col=colcode, add=T)
title(main="Area",
sub="Quantile (Equal-Frequency) Class Intervals")
legend(-117, 44, legend=names(attr(colcode, "table")),
    fill=attr(colcode, "palette"), cex=0.6, bty="n")
dev.off()

# Oregon county census data -- equal-frequency class intervals
png("image2-2.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
plotvar <- orcounty.shp@data$AREA
nclr <- 8
plotclr <- brewer.pal(nclr,"BuPu")
#plotclr <- plotclr[nclr:1] # reorder colors if appropriate
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
plot(orcounty.shp, xlim=c(-124.5, -115), ylim=c(42,47))
plot(orcounty.shp, col=colcode, add=T)
title(main="Area",
    sub=" Equal-Width Class Intervals")
legend(-117, 44, legend=names(attr(colcode, "table")),
    fill=attr(colcode, "palette"), cex=0.6, bty="n")
#equal-width class intervals of 1990 population
plotvar <- orcounty.shp@data$POP1990
nclr <- 8
plotclr <- brewer.pal(nclr,"BuPu")
#plotclr <- plotclr[nclr:1] # reorder colors if appropriate
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
plot(orcounty.shp, xlim=c(-124.5, -115), ylim=c(42,47))
plot(orcounty.shp, col=colcode, add=T)
title(main="Population 1990",
    sub=" Equal-Width Class Intervals")
legend(-117, 44, legend=names(attr(colcode, "table")),
    fill=attr(colcode, "palette"), cex=0.6, bty="n")
dev.off()

# Oregon county census data -- bubble plots
png("image2-3.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
# bubble plot equal-frequency class intervals
plotvar <- orcounty.shp@data$AREA
nclr <- 8
plotclr <- brewer.pal(nclr,"BuPu")
#plotclr <- plotclr[nclr:1] # reorder colors if appropriate
max.symbol.size=12
min.symbol.size=1
class <- classIntervals(plotvar, nclr, style="quantile")
colcode <- findColours(class, plotclr)
symbol.size <- ((plotvar-min(plotvar))/
    (max(plotvar)-min(plotvar))*(max.symbol.size-min.symbol.size)
    +min.symbol.size)
plot(orcounty.shp, xlim=c(-124.5, -115), ylim=c(42,47))
orcounty.cntr <- coordinates(orcounty.shp)
points(orcounty.cntr, pch=16, col=colcode, cex=symbol.size)
points(orcounty.cntr, cex=symbol.size)
    text(-120, 46.5, "Area: Equal-Frequency Class Intervals")
legend(-117, 44, legend=names(attr(colcode, "table")),
    fill=attr(colcode, "palette"), cex=0.6, bty="n")
# bubble plot equal-frequency class intervals
plotvar <- orcounty.shp@data$POP1990
nclr <- 8
plotclr <- brewer.pal(nclr,"BuPu")
#plotclr <- plotclr[nclr:1] # reorder colors if appropriate
max.symbol.size=12
min.symbol.size=1
class <- classIntervals(plotvar, nclr, style="quantile")
colcode <- findColours(class, plotclr)
symbol.size <- ((plotvar-min(plotvar))/
(max(plotvar)-min(plotvar))*(max.symbol.size-min.symbol.size)
+min.symbol.size)
plot(orcounty.shp, xlim=c(-124.5, -115), ylim=c(42,47))
orcounty.cntr <- coordinates(orcounty.shp)
points(orcounty.cntr, pch=16, col=colcode, cex=symbol.size)
points(orcounty.cntr, cex=symbol.size)
text(-120, 46.5, "Population: Equal-Frequency Class Intervals")
legend(-117, 44, legend=names(attr(colcode, "table")),
    fill=attr(colcode, "palette"), cex=0.6, bty="n")
dev.off()

# Oregon county census data -- (pseudo) dot-density maps
png("image2-4.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
# maptools dot-density maps
# warning: this can take a little while
plottitle <- "Population 1990, each dot=1000"
orpolys <- SpatialPolygonsDataFrame(orcounty.shp, data=as(orcounty.shp, "data.frame"))
plotvar <- orpolys@data$POP1990/1000.0
dots.rand <- dotsInPolys(orpolys, as.integer(plotvar), f="random")
plot(orpolys, xlim=c(-124.5, -115), ylim=c(42,47))
plot(dots.rand, add=T, pch=19, cex=0.5, col="magenta")
plot(orpolys, add=T)
title(plottitle)
dots.reg <- dotsInPolys(orpolys, as.integer(plotvar), f="regular")
plot(orpolys, xlim=c(-124.5, -115), ylim=c(42,47))
plot(dots.reg, add=T, pch=19, cex=0.5, col="purple")
plot(orpolys, add=T)
title(plottitle)
dev.off()

