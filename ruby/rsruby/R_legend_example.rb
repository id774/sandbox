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
  legend( 5, 105, c( "f = 2/3", "f = 0.2" ), lty = 1, col = c("red", "green") )
  dev.off()
RCOMMAND
