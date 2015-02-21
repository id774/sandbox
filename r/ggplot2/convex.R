
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
