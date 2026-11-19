# fib.rb: Memoized Fibonacci numbers with method_missing
#
# Description:
# Memoize Fibonacci numbers in a class variable and delegate the rest by
# method_missing.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby fib.rb
#
# Requirements:
# - Ruby
#

class Fib
  @@ary = []

  def self.[](i)
    return @@ary[i] if @@ary[i]
    case i
    when 0
      @@ary[i] = 0
    when 1
      @@ary[i] = 1
    else
      @@ary[i] = self[i-1]+self[i-2]
    end
  end

  def self.method_missing(name,*args)
    @@ary.__send__(name,*args)
  end

  def self.inspect
    @@ary.inspect
  end
end

if __FILE__ == $0
  p Fib
  10.times do |i|
    p Fib[i]
  end
  p Fib
  Fib[100]
  p Fib
end
