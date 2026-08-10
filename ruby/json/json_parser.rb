#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Fetch a JSON document over HTTP and parse it.

require 'net/http'
require 'uri'
require 'json'

uri = URI.parse('http://www.example.com/sample.json')
json = Net::HTTP.get(uri)
result = JSON.parse(json)
puts result
