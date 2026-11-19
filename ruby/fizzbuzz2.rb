# fizzbuzz2.rb: FizzBuzz with array indexing tricks
#
# Description:
# Print FizzBuzz for 1 through 100 using array indexing tricks.
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

1.upto(100){|i|s =[[:Fizz][i%3],[:Buzz][i%5]]*'';p s[1]?s:i}
