# -*- coding: utf-8 -*-

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
