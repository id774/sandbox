# fizzbuzz2.rb: FizzBuzz with a nested conditional
#
# Description:
# Print FizzBuzz for 1 through 100 with a nested conditional.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby fizzbuzz2.rb
#
# Requirements:
# - Ruby
#

def fizzbuzz(n)
    n % 15 == 0 ? 'FizzBuzz' : n % 5 == 0 ? 'Buzz' : n % 3 == 0 ? 'Fizz' : n.to_s
end

1.upto(100) do |i|
    puts fizzbuzz(i)
end

