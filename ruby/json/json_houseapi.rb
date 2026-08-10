#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Fetch sensor readings from an API and print the parsed JSON.

require 'net/http'
require 'uri'
require 'json'


puts "wifi clients"
result = JSON.parse(Net::HTTP.get(URI.parse('http://example.com/api/shibuhouse/wificlients?limit=10')))
puts result

puts "wifi temprature"
result = JSON.parse(Net::HTTP.get(URI.parse('http://example.com/api/shibuhouse/wifitemperature?period=day&limit=30')))
puts result

puts "kunugi sound"
result = JSON.parse(Net::HTTP.get(URI.parse('http://example.com/api/shibuhouse/bf_kunugi/sound&limit=20')))
puts result

