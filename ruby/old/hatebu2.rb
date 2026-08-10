# Scrape the Hatena Bookmark count for a URL with mechanize.

require 'open-uri'
require 'rubygems'
require 'mechanize'
include WWW

def get_count(url)
    agent = WWW::Mechanize.new
    page = agent.get('http://b.hatena.ne.jp/entry/'+url)
    page.at(".users").inner_text.gsub(/[^0-9]/,"").to_i
end
    # Reject on error
(puts "usage: hatebu.rb url";exit) if !ARGV[0]
# Initial fetch
bcount = get_count(ARGV[0].sub("http://",""))
puts "init #{bcount.to_i}"
puts "----"
loop do
    bcount2 = get_count(ARGV[0].sub("http://",""))
    puts "bcount #{bcount.to_i}"
    puts "bcount2 #{bcount2.to_i}"
    if bcount != bcount2
        system("say Detteiu")
        bcount = bcount2
        puts "say Detteiu"
    end
    puts "sleep 60"
    sleep 60
    puts "----"
end

