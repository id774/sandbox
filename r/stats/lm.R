# lm.R: Linear models of MacBook prices
#
# Description:
# Fit linear models of MacBook prices from the tab separated macbook_price.csv
# and select variables with step.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript lm.R
#
# Requirements:
# - R
# - macbook_price.csv in the current directory
#

df <- read.csv("macbook_price.csv", sep="\t")
result <- lm(df$PRICE ~ df$DISPLAY + df$RETINA + df$CPU + df$CORE + df$MEM + df$SSD)
summary(result)

result = lm(df$PRICE ~ df$CPU + df$CORE + df$MEM + df$SSD)
summary(result)

step(result)
