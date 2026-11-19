# R_scatterplot_example.rb: R scatter plot from CSV columns
#
# Description:
# Draw a scatter plot in R from the columns of Book1.csv through RSRuby.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby R_scatterplot_example.rb
#
# Requirements:
# - Ruby with the rsruby gem
# - R
# - Book1.csv in the current directory
#

require 'rubygems'
require "csv"
require 'rsruby'

reader = CSV.open("Book1.csv", "r")
header = reader.take(1)[0]

T = Hash::new
header.each do |attr|
  T[attr.strip] = []
end
reader.each do |row|
  i = 0
  row.each do |item|
    T[header[i].strip].push(item.strip)
    i = i + 1
  end
end

r = RSRuby::instance
r.eval_R(<<-RCOMMAND)
  X <- matrix( c( #{T["seq"].join(",")} ), 1, #{T["seq"].size} )
  Y <- matrix( c( #{T["USD"].join(",")} ), 1, #{T["USD"].size} )
  png(file="out.png")
  plot(X, Y)
  lines(lowess( X, Y ), col = "red")
  lines(lowess( X, Y, f=0.2 ), col = "green")
  dev.off()
RCOMMAND
