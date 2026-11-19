# prime.rb: Endless primes with the prime library
#
# Description:
# Print primes endlessly with the prime library.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby prime.rb
#
# Requirements:
# - Ruby
#

require 'prime'
Prime.each {|pr|puts pr}
