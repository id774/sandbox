#!/usr/bin/env ruby
# Read a web page line by line with open-uri.

require 'open-uri'
open("http://blog.id774.net/post/") do |f|
  f.each do |line|
    puts line
  end
end
