#-*- coding: utf-8 -*-
# follow_api.rb: Follow the Twitter filter stream for followed accounts
#
# Description:
# Follow the Twitter filter stream for a set of accounts; the modifier rescue
# does not parse. The accounts are those the user given as the first argument
# follows.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Requirements:
# - Ruby, although the current source does not parse
# - The rubytter gem
# - The Twitter streaming and REST APIs with basic authentication as they
#   existed at the time
#

require 'net/http'
require 'json'
require 'uri'
require 'cgi'
require 'kconv'
require 'rubytter'


uri = URI.parse('http://stream.twitter.com/1/statuses/filter.json')


Net::HTTP.start(uri.host,80) do |h|
    q = Net::HTTP::Post.new(uri.request_uri)
    q.basic_auth(ARGV[0],ARGV[1])
    h.request(q,'follow=' + Rubytter.new(ARGV[0],ARGV[1]).friends_ids(ARGV[0]).join(',')) do |r|
        r.read_body do |b|
            j = JSON.parse(b) rescue puts b
            puts j["text"] if j["text"]
        end
    end
end
