# 2.4_test2.rb: Integer unification of Fixnum and Bignum
#
# Description:
# Show that Ruby 2.4 unifies Fixnum and Bignum into Integer.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby 2.4_test2.rb
#
# Requirements:
# - Ruby 2.4 or later
#

p 1.class # Integer
p -1.class # Integer
p 10000000000000000000000000000.class # Integer
p -10000000000000000000000000000.class # Integer
