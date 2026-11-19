# break-the-ruby.rb: Undefine a method from inside itself
#
# Description:
# Call a method that undefines itself with undef, so the second call raises
# NoMethodError. The commented lines below are an earlier attempt to swap
# TrueClass and FalseClass and are not executed.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby break-the-ruby.rb
#
# Requirements:
# - Ruby
#

#a = TrueClass
#b = FalseClass
#TrueClass = b
#FalseClass = a
#true.instance_eval {
#  undef :&
#  undef :|
#  undef :^
#}
class Foobar
  def hoge
    puts "hogehoge"
    undef :hoge
  end
end
a = Foobar.new
a.hoge
a.hoge
