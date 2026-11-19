# fizzbuzz.rb: FizzBuzz in a single map
#
# Description:
# Print FizzBuzz for 1 through 100 in a single map.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby fizzbuzz.rb
#
# Requirements:
# - Ruby
#

puts (1..100).map{|i|s=(i%3==0?"Fizz":'')+(i%5==0?"Buzz":'');s==""?i:s}
