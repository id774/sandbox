# instance_variable_of.rb: Reach instance variables and define methods dynamically
#
# Description:
# Read an instance variable with instance_variable_get and instance_eval,
# answer a method through method_missing, and define a method with class_eval.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby instance_variable_of.rb
#
# Requirements:
# - Ruby
#

class Foo
  def initialize(message)
    @message = message
  end

  def method_missing(method, *args, &block)
    if method == :hi
      'hello'
    else
      super
    end
  end

end

foo = Foo.new('hi')
p foo.instance_variable_get( '@message' )
p foo.hi

Foo.class_eval %q[
  def greet
    "#{@message} you!"
  end
]

p foo.greet
p foo.instance_eval { @message }
