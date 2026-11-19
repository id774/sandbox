# args_pop.rb: Shift arguments off ARGV with defaults
#
# Description:
# Shift arguments off ARGV, falling back to defaults.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby args_pop.rb [arguments...]
#
# Requirements:
# - Ruby
#

class Test
  def initialize(args)
    @args_first = args.shift || "First"
    @args_second = args.shift || "Second"
    @args_third = args.shift || "Third"
  end

  def main
    p @args_first
    p @args_second
    p @args_third
  end
end

if __FILE__ == $0
  test = Test.new(ARGV)
  test.main
end
