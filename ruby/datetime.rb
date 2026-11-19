#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# datetime.rb: Parse, format, and add to Date and Time values
#
# Description:
# Parse and format a Date with strptime and strftime, build a Time with
# Time.local, and show the result of adding 1 to each.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby datetime.rb
#
# Requirements:
# - Ruby
#

# Date
require 'date'
datetime = Date.strptime("2012-10-15-11:10:15", "%Y-%m-%d-%H:%M:%S")
p datetime.strftime("%Y-%m-%d %H:%M:%S")
p datetime.to_s

datetime += 1
p datetime.to_s

# Time
datetime = Time.local(2012, 10, 15, 11, 10, 15)
p datetime.strftime("%Y-%m-%d %H:%M:%S")
p datetime.to_s

datetime += 1
p datetime.to_s
