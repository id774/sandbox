require 'sorry_yahoo_finance'
require 'awesome_print'

info = Stock::GET(8606)
ap info.values
