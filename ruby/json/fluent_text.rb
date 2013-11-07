#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'json'

open("fluent_out.log") do |file|
  file.each do |line|
    JSON.parse(line.scan(/\{.*\}/).join).each {|k,v|
      if k == "description"
        p v
      end
    }
  end
end
