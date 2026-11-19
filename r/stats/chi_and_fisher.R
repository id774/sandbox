# chi_and_fisher.R: Chi-squared and Fisher tests of a two by two table
#
# Description:
# Apply chisq.test and fisher.test to a fixed two by two table.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript chi_and_fisher.R
#
# Requirements:
# - R
#

x<-matrix(c(1625,5,1022,11),ncol=2,byrow=T)
chisq.test(x)
fisher.test(x)
