# fizzbuzz.rb: Digit-based FizzBuzz variant up to 1000
#
# Description:
# Print a digit based FizzBuzz variant up to 1000.
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

1.upto(1000) do |n|
    tmp = 0
    n.to_s.each_char{|n|tmp += n.to_i}
    str = "#{'fizz ' if /(0|5)/ =~ n.to_s[-1]}#{'buzz' if tmp == 3}"
    puts str if '' != str
    puts n.to_s if '' == str
 end
