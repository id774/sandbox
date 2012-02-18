#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class FeedParser
  require 'rss'
  require 'uri'
  require 'feedbag'

  def self.get_rss(url)
    target_links = []
    begin
      unless url.nil?
        feed_url = Feedbag.find(url).first(1).to_s
        print "[info] Feed URL: #{feed_url}\n"
        feed = URI.parse(feed_url).normalize
        open(feed) do |http|
          response = http.read
          rss_results = RSS::Parser.parse(response, false)
          rss_results.items.each do |item|
            target_links  << item.link
          end
        end
      end
    rescue => e
      raise e
    end
    return target_links
  end
end

if __FILE__ == $0
  url = ARGV.shift || abort("Usage: feed_parser.rb <url>")
  links = FeedParser.get_rss(url)
  p links
end
