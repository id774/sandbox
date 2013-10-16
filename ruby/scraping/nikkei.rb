#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'mechanize'

m = Mechanize.new
m.get "http://www.nikkei.com/news/editorial/"
#m.page.search('/html/body//h2[contains(., "社説")]').first.parent

list = m.page.search('//h4/a').map{|e| [e.text,"http://www.nikkei.com"+e["href"]] }
list.each{|e|
    m.get e[1]
    title = m.page.search('h4.cmn-article_title.cmn-clearfix').text.strip
    date  = m.page.search('h4.cmn-article_title.cmn-clearfix').text.strip
    body  = m.page.search('div.cmn-article_text.JSID_key_fonttxt').text.gsub(/\t/, "")
    open("#{title}-#{date}.txt","w"){|f| f.write body}
}
