#!/opt/ruby/2.2/bin/ruby
# super_method.rb: Reach an overridden parent method with super_method
#
# Description:
# Reach the overridden parent method through Method#super_method.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby super_method.rb
#
# Requirements:
# - Ruby 2.2 or later, which provides Method#super_method
#

class Parent
  def hoge
    "super hoge"
  end
end

class Child < Parent
  def hoge
    "child hoge"
  end
end

child = Child.new
p child.hoge
p child.public_method(:hoge).super_method
p child.public_method(:hoge).super_method.call
