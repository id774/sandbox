#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
# uri-encode.rb: Percent-encode a query before fetching a search page
#
# Description:
# Percent encode a query string before fetching a search page.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby uri-encode.rb
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
# - Network access to the search page in the source
#

require 'uri'
require 'open-uri'
keyword = URI::escape('ルビー')
open("http://www.google.co.jp/search?q=#{keyword}") do |f|
  f.each do |line|
    puts line
  end
end

