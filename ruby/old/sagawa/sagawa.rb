#-*- coding: utf-8 -*-
# sagawa.rb: Scrape a Sagawa parcel tracking page
#
# Description:
# Scrape the Sagawa parcel tracking page for the tracking number given as an
# argument.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby sagawa.rb <tracking number>
#
# Requirements:
# - Ruby
# - The hpricot gem
# - Network access to the Sagawa tracking site
#

require 'rubygems'
require 'net/http'
require 'hpricot'
require 'kconv'
require 'cgi'

class String
    def unescape_html
        CGI.unescapeHTML(self)
    end
end

class SagawaTracking
    def initialize(tracking_no)
        Net::HTTP.version_1_2

        n = Hpricot( Net::HTTP.start('k2k.sagawa-exp.co.jp', 80) do |h|
            h.post('/p/web/okurijosearch.do',
                  'okurijoNo='+tracking_no.to_s).body.unescape_html.toutf8
        end )
        @latest_activity = n.search("td.ichiran-fg2")[6].inner_text
        @detail = n.search("td.ichiran-fg2")[24].inner_text.gsub(/^\s+/,"")
        @pickuped_point = ""
        @destination_point = ""
        raise ArgumentError, "Wrong tracking_no" if /お問い合わせNo.をお確かめ下さい。/u =~ @detail
    end

    attr_reader :detail, :latest_activity
end

(puts "usage: sagawa.rb TRACKING_NUMBER";exit) unless ARGV[0]

sagawa = SagawaTracking.new(ARGV[0])

puts sagawa.latest_activity
puts "----"
puts sagawa.detail
