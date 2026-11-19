# get_title.rb: Crawl a site with Anemone and print page titles
#
# Description:
# Crawl a site with Anemone and print the title of every page.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby get_title.rb
#
# Requirements:
# - Ruby
# - The anemone gem
# - Network access to the site in the source
#

require 'anemone'

Anemone.crawl("http://www.id774.net") do |anemone|
  anemone.on_every_page do |page|
    title = page.doc.xpath("//head/title/text()").first.to_s if page.doc
    puts title
  end
end
