# laplace-distribution.R: Laplace-like densities for ten scale values
#
# Description:
# Overlay ten curves of (1/2) i e^(-i|x|) for i from 1 to 10.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript laplace-distribution.R
#
# Requirements:
# - R
#

for(i in 1:10){
  plot(function(x)(1/2)*i*exp(1)^(-i*abs(x)),from=-5,to=5,col=i,ylim=c(0,0.5))
  par(new=T)
}
