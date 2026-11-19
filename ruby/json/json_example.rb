#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# json_example.rb: JSON parse, load, generate, and dump
#
# Description:
# Exercise JSON parse, load, generate, and dump.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby json_example.rb
#
# Requirements:
# - Ruby
#

require 'json'
p JSON.parse('[1,2,3]')
p JSON.parse('{"foo":"bar"}')

open("file.json") do |io|
  p JSON.load(io)
end

open("file.json") do |io|
  JSON.load(io, proc{|v|p v})
end

p JSON.generate({"foo" => "bar"})

p 1.to_json
time = Time.local(2013,05,29,10,00,00)
p time
p time.to_json

p JSON.pretty_generate({"foo" => "bar"})

open("file.json","w") do |io|
  JSON.dump([1,2,3, {"foo" => "bar"}], io)
end

