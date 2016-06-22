require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'nkf'

def parse(url)
  charset = nil
  html = open(url) do |f|
    charset = f.charset
    f.read
  end

  doc = Nokogiri::HTML.parse(html, nil, charset)

  doc.xpath('//span[@class="icoQ"]').each do |node|
    puts "質問, \"#{node.text.strip}\""
  end

  doc.xpath('//div[@class="faq_ansCont_txt clearfix"]').each do |node|
    puts "回答, \"#{node.text.strip}\""
  end
end

(1..9999).each do |i|
  url = "https://faq.mizuho-sc.com/faq/show/#{i}"
  parse(url)
end
