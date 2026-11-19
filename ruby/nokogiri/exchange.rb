# exchange.rb: USD/JPY bid and ask scraped with Nokogiri
#
# Description:
# Scrape the USD/JPY bid and ask prices with Nokogiri.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby exchange.rb
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
# - The nokogiri gem
# - Network access to the quote page in the source
#

require 'nokogiri'
require 'open-uri'

url = 'http://info.finance.yahoo.co.jp/fx/detail/?code=USDJPY=FX'
doc = Nokogiri::HTML(open(url))
bid = doc.xpath("//*[@id='USDJPY_detail_bid']").text
ask = doc.xpath("//*[@id='USDJPY_detail_ask']").text
puts "Bid (売値) : #{bid}"
puts "Ask (買値) : #{ask}"
