#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# lazy_select.rb: Lazy select and map over a range
#
# Description:
# Chain select and map lazily over a range.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby lazy_select.rb
#
# Requirements:
# - Ruby 2.0 or later, which provides Enumerator::Lazy
#

p (1..100).lazy.select{|n| n.even?}.map{|n| n.to_s}.each{|s| p s}
