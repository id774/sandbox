# read_shp.R: Plot a shapefile
#
# Description:
# Read the polygons of 1.shp with maptools and write the plot to image.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript read_shp.R
#
# Requirements:
# - R with the gpclib, maptools, and RColorBrewer packages
# - 1.shp and its companion files in the current directory
#

library(gpclib)
library(maptools)
library(RColorBrewer)

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
pict <- readShapePoly("1.shp")
plot(pict)
dev.off()

