#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# criteria.rb: Minimum length rule answering allow?
#
# Description:
# Wrap a minimum length rule in a class that answers allow?.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby criteria.rb
#
# Requirements:
# - Ruby
#

class Criteria
  def initialize(length)
    @length = length
  end

  def allow?(s)
    s.length >= @length
  end
end
