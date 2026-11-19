#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# json_houseapi.rb: Sensor readings fetched as JSON
#
# Description:
# Fetch sensor readings from placeholder example.com API endpoints and print
# the parsed JSON.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby json_houseapi.rb
#
# Requirements:
# - Ruby
# - Network access to a real API in place of the placeholder host
#

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

