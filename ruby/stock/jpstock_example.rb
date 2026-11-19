# jpstock_example.rb: Sector, quote, price, and history of one stock
#
# Description:
# Fetch the sector, quote, price, and history of one stock.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby jpstock_example.rb
#
# Requirements:
# - Ruby
# - The jpstock and awesome_print gems
#

require 'jpstock'
require 'awesome_print'

code = "9613"

ap JpStock.sector(:code=>code)
ap JpStock.quote(:code=>code)
ap JpStock.price(:code=>code)
ap JpStock.historical_prices(:code=>code, :start_date=>Date.new(2014,10,1), :end_date=>Date.today)
