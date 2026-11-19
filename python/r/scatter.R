# scatter.R: Scatter plot of wine prices against rainfall
#
# Description:
# Plot wine prices against rainfall from a data frame named data, which
# scatter.py prepares through pyper, and write image.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Requirements:
# - R, run through scatter.py
#

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)

plot(data$WRAIN, data$LPRICE2, pch=16,
     xlab="収穫前年の10月〜3月の雨量",
     ylab="ワインの価格")

dev.off()
