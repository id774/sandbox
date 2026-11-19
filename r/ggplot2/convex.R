# convex.R: Convex hulls of iris petals with ggplot2
#
# Description:
# Plot iris petal width against length with ggplot2, then add the convex hull
# of all points and of each species, writing image.png through image3.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript convex.R
#
# Requirements:
# - R with the dplyr and ggplot2 packages
#

library(dplyr)
library(ggplot2)

df <- iris

png("image.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
p <- ggplot(df, aes(x = Petal.Width, y = Petal.Length)) + 
  geom_point()
p
dev.off()

png("image2.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
chull(df[c('Petal.Width', 'Petal.Length')])
hulls <- df[chull(df[c('Petal.Width', 'Petal.Length')]), ]
hulls
p + geom_polygon(data = hulls, alpha = 0.2)
dev.off()

png("image3.png", width = 480, height = 480, pointsize = 12, bg = "white", res = NA)
p <- ggplot(df, aes(x = Petal.Width, y = Petal.Length, colour = Species)) + 
  geom_point()

hulls <- df %>%
  dplyr::group_by(Species) %>%
  dplyr::do(.[chull(.[c('Petal.Width', 'Petal.Length')]), ])
hulls
p + geom_polygon(data = hulls, alpha = 0.2)
dev.off()
