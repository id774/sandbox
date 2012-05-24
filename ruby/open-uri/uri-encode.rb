#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'uri'
require 'open-uri'
keyword = URI::escape('ルビー')
open("http://www.google.co.jp/search?q=#{keyword}") do |f|
  f.each do |line|
    puts line
  end
end

