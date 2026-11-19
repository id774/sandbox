# phi.R: Phi coefficient of two binary outcomes
#
# Description:
# Read input.txt, code the Result and Classify columns as 0 or 1, and print
# their cross table and correlation.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript phi.R
#
# Requirements:
# - R
# - input.txt with Result and Classify columns in the current directory
#

dataflame <- read.table("input.txt", sep="\t", header=TRUE)

x <- ifelse(dataflame$Result=="失注",0,1)
y <- ifelse(dataflame$Classify=="Positive",1,0)

table(dataflame$Result, dataflame$Classify)
cor(x, y)
