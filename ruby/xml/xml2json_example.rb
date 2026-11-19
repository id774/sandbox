#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# xml2json_example.rb: Convert an XML API response into JSON
#
# Description:
# Convert an XML API response into JSON with ActiveSupport. The application ID
# in the URL is a placeholder.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby xml2json_example.rb
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
# - The activesupport gem
# - A real statistics API application ID in place of the placeholder
#

require 'active_support/core_ext'
require 'open-uri'

url = "http://statdb.nstac.go.jp/api/1.0b/app/getStatsData?appId=xxxxxxxxxxxx&statsDataId=0003013276&cdArea=09003,22004&cdCat01=010920070&cdTimeFrom=2012000101&cdTimeTo=2013000303"

hash = Hash.from_xml open(url).read
json = hash.to_json

puts json

data = ActiveSupport::JSON.decode(json)
puts data

json2 = ActiveSupport::JSON.encode(data)
puts json2

data2 = ActiveSupport::JSON.decode(json2)
puts data2

p "OK" if data == data2
