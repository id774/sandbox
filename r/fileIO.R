# fileIO.R: Read and write a tab-separated file
#
# Description:
# Read the tab separated input.txt and write it to output.txt without quotes,
# column names, or row names.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript fileIO.R
#
# Requirements:
# - R
# - input.txt in the current directory
#

dataflame <- read.table("input.txt", sep="\t")

write.table(dataflame, file="output.txt", quote=F, col.names=F, row.names=F, sep="\t")
