#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'net/http'
require 'uri'
require 'json'

uri = URI.parse('http://133.242.144.202/shibuhouse/bf_kunugi_sound?limit=10')
json = Net::HTTP.get(uri)
result = JSON.parse(json)
puts result
