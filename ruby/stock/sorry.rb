# sorry.rb: One stock quote with sorry_yahoo_finance
#
# Description:
# Fetch one stock quote with sorry_yahoo_finance.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby sorry.rb
#
# Requirements:
# - Ruby
# - The sorry_yahoo_finance and awesome_print gems
#

require 'sorry_yahoo_finance'
require 'awesome_print'

info = Stock::GET(8606)
ap info.values
