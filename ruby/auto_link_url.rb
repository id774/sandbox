#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'minitest/unit'
require 'uri'
require 'cgi'
 
def auto_link_url(text)
  text.gsub(/(#{URI.regexp(%w(http https))})/) do
    %w(http:// https://).include?($1) ? $1 : %Q|<a href="#{CGI.escape_html $1}">#{CGI.escape_html $1}</a>|
  end
end
 
class TestAutoLinkUrl < MiniTest::Unit::TestCase
  def test_auto_link_url
    {
      "http://" => "http://",
      "https://" => "https://",
      "ftp://www.example.com/" => "ftp://www.example.com/",
      "http://www.example.com/" => "<a href=\"http://www.example.com/\">http://www.example.com/</a>",
      "https://www.example.com/" => "<a href=\"https://www.example.com/\">https://www.example.com/</a>",
      "http://www.example.com/日本語" => "<a href=\"http://www.example.com/\">http://www.example.com/</a>日本語",
      "http://www.example.com/%E3%81%82" => "<a href=\"http://www.example.com/%E3%81%82\">http://www.example.com/%E3%81%82</a>",
      "http://www.example.com?key1=value1&key2=value2#hash" => "<a href=\"http://www.example.com?key1=value1&amp;key2=value2#hash\">http://www.example.com?key1=value1&amp;key2=value2#hash</a>",
      "https://www.example.com?key1=value1&key2=value2#hash" => "<a href=\"https://www.example.com?key1=value1&amp;key2=value2#hash\">https://www.example.com?key1=value1&amp;key2=value2#hash</a>",
      "http://www.example.com/?key=%E3%81%82" => "<a href=\"http://www.example.com/?key=%E3%81%82\">http://www.example.com/?key=%E3%81%82</a>",
      "先頭http://www.example.com/末尾" => "先頭<a href=\"http://www.example.com/\">http://www.example.com/</a>末尾",
      "http://www.example.com/とhttp://www.example.com/" => "<a href=\"http://www.example.com/\">http://www.example.com/</a>と<a href=\"http://www.example.com/\">http://www.example.com/</a>",
      "http://www.example.com/\"onclick=\"javascript:alert('alert');" => "<a href=\"http://www.example.com/\">http://www.example.com/</a>\"onclick=\"javascript:alert('alert');",
    }.each do |text, link|
      assert_equal link, auto_link_url(text)
    end
  end
end
 
MiniTest::Unit.autorun
