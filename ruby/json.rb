#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

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

