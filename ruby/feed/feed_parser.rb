class FeedParser
  require 'rss'
  require 'uri'

  attr_accessor :title, :description, :link, :published_at

  def initialize
    @title = nil
    @description = nil
    @link = nil
    @published_at = nil 
  end

  def self.get_rss(rss_url)
    begin
      ary = []
      unless rss_url.nil?
        rss_results = ""
        url = URI.parse(rss_url).normalize
        open(url) do |http|
          response = http.read
          rss_results = RSS::Parser.parse(response, false)
          rss_results.items.each do |item|
            obj = self.new
            obj.title = item.title
            obj.description = item.description
            obj.link = item.link
            obj.published_at = item.date
            ary << obj
          end
        end
      end
      return ary
    rescue => e
      raise e
    end
  end
end

if __FILE__ == $0
  rss_url = ARGV.shift || abort("Usage: feed_parser.rb <url>")
  rss = FeedParser.get_rss(rss_url)
end
