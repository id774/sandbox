require 'rubygems'
require 'rubytter'
require 'rss'

twitter_id ="googeousbot"
twitter_pass ="hogehoge"
tw =Rubytter.new(twitter_id,twitter_pass)
puts "Running..."
#キャッシュファイルの生成
@file =File.open("googeous_cache.dat","a+")


#読み込んで配列にしちゃう
l=0
cache = Array.new
while l == @file.gets
	l +=1
	cache[l] = @file.readlines[l]
end
@file.close


#twitter検索からRSSを取得する
posted =Array.new
open('http://pcod.no-ip.org/yats/public_timeline?rss') do |http|
  response = http.read
  result = RSS::Parser.parse(response, false)
  result.items.each_with_index do |item, i|
    status ="#{item.summary}"
    status.scan(/(ぐーじゃすなう|グージャスなう)/){ |matched|
    	userid ="#{item.title}"
    	userid = userid.gsub(/\<.*?title\>/,"")
    	statusid = "#{item.id}".gsub(/\<.*?id\>/,"")
    	flag =true
    	#キャッシュを読んで、既に投稿済みか確認
    	cache.each do |id|
    		if id==statusid
    			flag=false
    			break
    		end
    	end
    	if flag
    	#投稿済みじゃないとき
    		m= "@"+userid+" さんがグージャスなうしました。"
    		puts m
    		begin
    		tw.follow(userid)
    		tw.update(m)
    		rescue
    		puts "follow済みのようです。"
    		tw.update(m)
    		end
    		posted.push(statusid)
    	end
    }
  end
end

#キャッシュファイルへの書き込み
@file =File.open("googeous_cache.dat","a")
posted.each do |id|
	@file.puts id
end
@file.close

