#-*- coding: utf-8 -*-
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
