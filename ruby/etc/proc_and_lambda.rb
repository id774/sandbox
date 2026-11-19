#!/usr/bin/ruby env
# proc_and_lambda.rb: return in a Proc and in a lambda
#
# Description:
# Show how return behaves differently in a Proc and in a lambda.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby proc_and_lambda.rb
#
# Requirements:
# - Ruby
#

def method_Proc
  obj = Proc.new { return 10 }
  res = obj.call
  res * 2
end

def method_lambda
  obj = lambda { return 10 }
  res = obj.call
  res * 2
end

p method_Proc   # => 10
p method_lambda # => 20

