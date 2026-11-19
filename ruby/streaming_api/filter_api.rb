#-*- coding: utf-8 -*-
# filter_api.rb: Follow the Twitter filter stream for keywords
#
# Description:
# Follow the Twitter filter stream for the keywords given as the third
# argument, authenticating with the user name and password given as the first
# two.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby filter_api.rb <user> <password> <keywords>
#
# Requirements:
# - Ruby
# - The Twitter streaming API with basic authentication as it existed at the
#   time
#

require 'net/http'
require 'json'
require 'uri'
require 'cgi'
require 'kconv'

abort 'usage: sample_api.rb username password keyword[,keyword,...]' unless ARGV.length >= 3

uri = URI.parse('http://stream.twitter.com/1/statuses/filter.json')

Net::HTTP.start(uri.host,80) do |h|
    q = Net::HTTP::Post.new(uri.request_uri)
    q.basic_auth(ARGV[0],ARGV[1])
    h.request(q,'track=' + CGI.escape(ARGV[2].toutf8)) do |r|
        r.read_body do |b|
            j = JSON.parse(b) rescue next
            puts j["text"] if j["text"]
        end
    end
end
