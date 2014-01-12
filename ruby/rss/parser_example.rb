# -*- coding: utf-8 -*-

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

