#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# normal_select.rb: Eager select and map over a range
#
# Description:
# Chain select and map eagerly over a range, for comparison.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby normal_select.rb
#
# Requirements:
# - Ruby
#

p (1..100).select{|n| n.even?}.map{|n| n.to_s}.each{|s| p s}
