#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Poll a quote page and extract the price change with a regular expression.

require "open-uri"
loop do
  puts( open("http://finance.google.com/finance?cid=983582").read[
  /<span class="\w+" id="ref_983582_c">([+-]?\d+\.\d+)/m, 1] )
  sleep(10)
end
