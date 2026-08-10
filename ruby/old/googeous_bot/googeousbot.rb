# Post RSS entries to Twitter, keeping a cache of what was already sent.

require 'rubygems'
require 'rubytter'
require 'rss'

twitter_id ="googeousbot"
twitter_pass ="hogehoge"
tw =Rubytter.new(twitter_id,twitter_pass)
puts "Running..."
# Create the cache file
@file =File.open("googeous_cache.dat","a+")


# Read it into an array
l=0
cache = Array.new
while l == @file.gets
	l +=1
	cache[l] = @file.readlines[l]
end
@file.close


# Fetch the RSS feed of a Twitter search
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
    	# Read the cache and check whether it was already posted
    	cache.each do |id|
    		if id==statusid
    			flag=false
    			break
    		end
    	end
    	if flag
    	# When it has not been posted yet
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

# Write to the cache file
@file =File.open("googeous_cache.dat","a")
posted.each do |id|
	@file.puts id
end
@file.close

