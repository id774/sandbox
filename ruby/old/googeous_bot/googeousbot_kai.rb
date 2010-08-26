# -*- coding: utf-8 -*-
# Googeous bot
# Author: gigi-net
# Modified by: Sora Harakami

require 'rubygems'
require 'rubytter'
require 'rss'

debug = true
twitter_id ="googeousbot"
twitter_pass ="hogehoge"
tw = Rubytter.new(twitter_id,twitter_pass) unless debug
puts "Running..."

#読み込んで配列にしちゃう
posted = File.exists?("googeous_cache.dat") ? File.read("googeous_cache.dat").split("\n") : []
count = File.exists?("googeous_counter.dat") ? Hash[File.read("googeous_counter.dat").split("\n").map do |n|
    n = n.split(" ")
    n[1] = n[1].to_i
    n
end.flatten] : {}

p posted if debug
p count if debug

#twitter検索からRSSを取得する

RSS::Parser.parse(open('http://search.twitter.com/search.atom?q=%28%E3%82%B0%E3%83%BC%E3%82%B8%E3%83%A3%E3%82%B9+OR+%E3%81%90%E3%83%BC%E3%81%98%E3%82%83%E3%81%99%29+%E3%81%AA%E3%81%86'){|h|h.read}, false).items.each do |item|
    status = item.content.content
    userid = item.author.uri.content.gsub(/^.+twitter\.com\//,"")
    statusid = item.link.href

    if posted.index(statusid).nil? && !(/googeousbot/ =~ statusid)
        #投稿済みじゃないとき
        #カウント
        unless count[userid.to_s].nil?
            count[userid.to_s] += 1
        else
            count[userid.to_s] = 1
        end
        m = "@#{userid} さんがグージャスなうしました。 (#{count[userid.to_s].to_s}回目)"
        puts m+" - #{statusid.gsub(/^.+\.com\//,"").gsub(/statuses\//,"")}"
        begin
            tw.follow(userid) unless debug
        rescue Rubytter::APIError
        end
        begin
            tw.update(m) unless debug
        rescue Rubytter::APIError
            puts "postに失敗 (APIError)"
        end
        posted << statusid # remaked: <<のほうが高速・・らしいよ・・・
    elsif !(/googeousbot/ =~ statusid)
        puts "@#{userid} さんはグージャスなうしてました。 - #{statusid.gsub(/^.+\.com\//,"").gsub(/statuses\//,"")}"
    end
end
#キャッシュファイルへの書き込み (なければ生成)
File.open("googeous_cache.dat","w") do |f|
    f.print posted.join("\n")
end

File.open("googeous_counter.dat","w") do |f|
    tmp = ""
    count.each do |id,count|
        tmp += "#{id} #{count.to_s}\n"
    end
    f.print tmp
end


