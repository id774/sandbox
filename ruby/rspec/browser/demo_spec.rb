# -*- coding: utf-8 -*-
# demo_spec.rb: Check live site pages with RSpec and Nokogiri
#
# Description:
# Check a live site's pages with RSpec and Nokogiri.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     rspec demo_spec.rb
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
# - RSpec 2, or RSpec 3 with the should syntax enabled
# - The nokogiri gem and network access to the site in the source
#

require File.dirname(__FILE__) + '/../spec_helper'

require 'open-uri'
require 'nokogiri'

url = "http://id774.net"
opt = "-s -xm0"

describe 'マイホームページ' do
  context 'にアクセスする場合' do

    describe 'トップページを開くと' do
      it "トップページが表示される" do
        @links = []
        doc = Nokogiri::HTML(open(url).read)
        (doc/:a).each {|link|
          @links << link[:href]
        }
        @links.should have(36).items
        @links[3].should == "http://blog.id774.net/post/"
        @links[4].should == "http://reblog.id774.net"
      end
    end

  end
end
