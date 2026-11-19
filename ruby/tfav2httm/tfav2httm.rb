# tfav2httm.rb: Repost Twitter favorites to Tumblr and Hatena Bookmark
#
# Description:
# Repost Twitter favourites to Tumblr and Hatena Bookmark, using the accounts
# and state file named in the YAML configuration given as an argument.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby tfav2httm.rb <config file>
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
# - The tumblr and hatenabm gems
# - The Twitter favorites RSS feed, Tumblr, and Hatena Bookmark services as
#   they existed at the time
#

require 'rubygems'
require 'tumblr'
require 'hatenabm'
require 'open-uri'
require 'rss'
require 'yaml'
##################
#read config
(puts "usage: tfav2httm.rb config-file";exit) if !ARGV[0]
config = YAML.load_file(ARGV[0])
File.open(config["tmpfile"],"w"){|f|f.print "0"} if !File.exists?(config["tmpfile"])
#read favs
favs = open("http://twitter.com/favorites/#{config["twitter"]["user"]}.rss"){|f|RSS::Parser.parse(f.read)}
last = File.read(config["tmpfile"])
p last
if last == "0"
    item = favs.items[0]
        #post2hatena
        HatenaBM.new(:user => config["hatena"]["user"],:pass => config["hatena"]["pass"]).post(
            :title => "Twitter / "+item.title,
            :link => item.link,
            :tags => "twitter",
            :summary => item.description.sub(/.+: /,"")
        )
        #post2tumblr
        Tumblr::API.write(config["tumblr"]["mail"],config["tumblr"]["pass"]) do
            post("type" => "quote", "quote" => item.description.sub(/.+: /,""), "source" => item.link,"tags" => "twitter")
        end
    File::open(config["tmpfile"],"w"){|f|f.print favs.items[0].link}

    exit 0
end

if last != favs.items[0].link
    puts "New Posts detected"
    i = 0
    favs.items.each do |item|
        break if i >= 6
        break if item.link == last
        puts item.description
        #post2hatena
        HatenaBM.new(:user => config["hatena"]["user"],:pass => config["hatena"]["pass"]).post(
            :title => "Twitter / "+item.title,
            :link => item.link,
            :tags => "twitter",
            :summary => item.description.sub(/.+: /,"")
        )
        #post2tumblr
        Tumblr::API.write(config["tumblr"]["mail"],config["tumblr"]["pass"]) do
            post("type" => "quote", "quote" => item.description.sub(/.+: /,""), "source" => item.link,"tags" => "twitter")
        end
        i += 1
    end
    File::open(config["tmpfile"],"w"){|f|f.print favs.items[0].link}
    
end
