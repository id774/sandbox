#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# rexml_example.rb: Print a statistics API response with REXML
#
# Description:
# Fetch a statistics API response and print it with REXML. The application ID
# in the URL is a placeholder.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby rexml_example.rb
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
# - A real statistics API application ID in place of the placeholder
#

require 'rexml/document'
require 'open-uri'

url = "http://statdb.nstac.go.jp/api/1.0b/app/getStatsData?appId=xxxxxxxxxxxx&statsDataId=0003013276&cdArea=09003,22004&cdCat01=010920070&cdTimeFrom=2012000101&cdTimeTo=2013000303"
doc = REXML::Document.new(open(url))

puts doc
