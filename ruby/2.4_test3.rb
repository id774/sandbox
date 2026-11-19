# 2.4_test3.rb: Match an empty symbol against an empty regexp
#
# Description:
# Match an empty symbol against an empty regular expression.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby 2.4_test3.rb
#
# Requirements:
# - Ruby 2.4 or later, which provides Symbol#match returning MatchData
#

p :"".match(//)
