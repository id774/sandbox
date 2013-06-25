#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'json'

open("fluent_out.log") do |file|
  file.each do |line|
    p JSON.parse(line.scan(/\{.*\}/).join)
  end
end
