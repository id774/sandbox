# -*- coding: utf-8 -*-

require 'rubygems'
require "csv"
require 'rsruby'
require 'awesome_print'

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
  seq  <- c( #{T["seq"].join(",")} )
  date <- c( #{T["date"].join(",")} )
  USD  <- c( #{T["USD"].join(",")} )
  EUR  <- c( #{T["EUR"].join(",")} )
  AUD  <- c( #{T["AUD"].join(",")} )
  D = data.frame( cbind( seq = seq, date = date, USD = USD, EUR = EUR, AUD = AUD ) )
  result = summary(D)
RCOMMAND

ap r.result
