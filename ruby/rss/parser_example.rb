# -*- coding: utf-8 -*-
# parser_example.rb: Parse an RSS feed and print its entries
#
# Description:
# Parse the RSS feed at the URL given as an argument and print its entries.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby parser_example.rb <feed URL>
#
# Requirements:
# - Ruby
# - Network access to the feed
#

require 'rss'

class RSSParser
  def initialize(args)
    @rss_source = args.shift
  end

  def parse
    rss = nil

    begin
      rss = RSS::Parser.parse(@rss_source)
    rescue RSS::InvalidRSSError
      rss = RSS::Parser.parse(@rss_source, false)
    end

    return rss
  end
end

if __FILE__ == $0
  rss_parser = RSSParser.new(ARGV)
  puts rss_parser.parse
end

