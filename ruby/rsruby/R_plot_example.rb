# R_plot_example.rb: R script plotting a CSV to PNG
#
# Description:
# Run an R script through RSRuby that plots Book1.csv to out.png.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby R_plot_example.rb
#
# Requirements:
# - Ruby with the rsruby gem
# - R
# - Book1.csv in the current directory
#

require 'rubygems'
require 'rsruby'
r = RSRuby::instance

r.eval_R(<<-RCOMMAND)
  X <- read.table("Book1.csv", header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE);
  png(file="out.png")
  plot( X[,c("seq")], X[,c("USD")] )
  dev.off()
RCOMMAND
