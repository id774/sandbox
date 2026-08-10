#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
# Percent encode a query string before fetching a search page.

require 'uri'
require 'open-uri'
keyword = URI::escape('ルビー')
open("http://www.google.co.jp/search?q=#{keyword}") do |f|
  f.each do |line|
    puts line
  end
end

