#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# fluent_text.rb: Description fields from a fluentd log
#
# Description:
# Print the description field out of the JSON in fluent_out.log in the current
# directory.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby fluent_text.rb
#
# Requirements:
# - Ruby
# - fluent_out.log in the current directory
#

require 'json'

open("fluent_out.log") do |file|
  file.each do |line|
    JSON.parse(line.scan(/\{.*\}/).join).each {|k,v|
      if k == "description"
        p v
      end
    }
  end
end
