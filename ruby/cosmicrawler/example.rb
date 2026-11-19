# example.rb: Concurrent crawl with Cosmicrawler
#
# Description:
# Crawl several pages concurrently with Cosmicrawler.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby example.rb
#
# Requirements:
# - Ruby
# - The cosmicrawler gem
# - Network access to the pages in the source
#

require 'cosmicrawler'

Cosmicrawler.http_crawl(%w(http://b.hatena.ne.jp/hotentry/it http://b.hatena.ne.jp/hotentry/life)) {|request|
  get = request.get
  puts get.response if get.response_header.status == 200
}

