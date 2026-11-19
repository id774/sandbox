#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# regex.rb: Extract a price change from a quote page
#
# Description:
# Poll a quote page and extract the price change with a regular expression.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby regex.rb
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
# - Network access to the quote page in the source
#

require "open-uri"
loop do
  puts( open("http://finance.google.com/finance?cid=983582").read[
  /<span class="\w+" id="ref_983582_c">([+-]?\d+\.\d+)/m, 1] )
  sleep(10)
end
