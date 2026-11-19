#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# json_parser.rb: Fetch and parse a JSON document over HTTP
#
# Description:
# Fetch a JSON document from a placeholder example.com URL over HTTP and parse
# it.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby json_parser.rb
#
# Requirements:
# - Ruby
# - Network access to a real JSON URL in place of the placeholder
#

require 'net/http'
require 'uri'
require 'json'

uri = URI.parse('http://www.example.com/sample.json')
json = Net::HTTP.get(uri)
result = JSON.parse(json)
puts result
