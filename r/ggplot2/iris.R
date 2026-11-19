# iris.R: qplot variations on the iris data set
#
# Description:
# Draw iris petal scatter plots with qplot, varying color, shape, and size by
# species and sepal length.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript iris.R
#
# Requirements:
# - R with the ggplot2 package, in a release that still provides qplot
#

library(ggplot2)

qplot(data=iris, x=Petal.Length, y=Petal.Width)
# 色分け 凡例つき
qplot(data=iris, x=Petal.Length, y=Petal.Width, color=Species)
# 形で変える
qplot(data=iris, x=Petal.Length, y=Petal.Width, shape=Species)
# 大きさ
qplot(data=iris, x=Petal.Length, y=Petal.Width, color=Species, size=Sepal.Length)
# 層を重ねる（回帰曲線を重ねる）
qplot(data=iris, x=Petal.Length, y=Petal.Width)+stat_smooth()
qplot(data=iris, x=Petal.Length, y=Petal.Width, color=Species)+ stat_smooth()
# ヒストグラム
qplot(data=iris, x=Petal.Length, geom="histogram")
qplot(data=iris, x=Petal.Length, geom="histogram", fill=Species)
# 密度グラフ
qplot(data=iris, x=Petal.Length, geom="density")
# 半透明
qplot(data=iris, x=Petal.Length, geom="density", fill=Species, alpha=0.3)

ggsave("image.png")

