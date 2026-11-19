#!/usr/bin/env ruby
# sha1.rb: SHA-1 digest of an argument
#
# Description:
# Print the SHA-1 digest of the argument, or of "test" when no argument is
# given.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby sha1.rb [string]
#
# Requirements:
# - Ruby
#

require 'digest/sha1'

def compute_sha1(str)
  puts Digest::SHA1.hexdigest(str)
end

if __FILE__ == $0
  str=ARGV.shift || "test";
  compute_sha1(str)
end

