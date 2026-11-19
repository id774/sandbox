#!/opt/ruby/2.2/bin/ruby
# binding_variables.rb: Local variables visible through binding
#
# Description:
# List the local variables visible through binding inside a method.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby binding_variables.rb
#
# Requirements:
# - Ruby 2.2 or later, which provides Binding#local_variables
#

require 'pp'

class Hoge
  def hoge(msg)
    a = 1
    b = 2
    pp binding.local_variables
  end
end

Hoge.new.hoge("@@hoge@@")
