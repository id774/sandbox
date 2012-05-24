#!/usr/bin/env ruby

require 'open-uri'
open("http://blog.id774.net/post/") do |f|
  f.each do |line|
    puts line
  end
end
