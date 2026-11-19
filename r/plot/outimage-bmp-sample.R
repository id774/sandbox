# outimage-bmp-sample.R: Save a scatter plot as BMP
#
# Description:
# Plot fixed test scores against study times and save the plot as graphic.bmp.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript outimage-bmp-sample.R
#
# Requirements:
# - R
#

time <- c(1,3,10,12,6,3,8,4,1,5)
test <- c(20,40,100,80,50,50,70,50,10,60)

bmp(filename = "graphic.bmp", width = 480, height = 480,
   pointsize = 12, bg = "white", res = NA)
plot(time, test)
dev.off()

