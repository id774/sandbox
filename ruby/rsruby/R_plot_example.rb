require 'rubygems'
require 'rsruby'
r = RSRuby::instance

r.eval_R(<<-RCOMMAND)
  X <- read.table("Book1.csv", header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE);
  png(file="out.png")
  plot( X[,c("seq")], X[,c("USD")] )
  dev.off()
RCOMMAND
