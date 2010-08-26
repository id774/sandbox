#!/usr/bin/env ruby
require "net/http"
require "cgi"
require "open-uri"

def get_youtube_mp4(url,fmt=18)
    t = open(url) { |h| h.read.gsub(/^.+"t": "/m,"").gsub(/", .+$/m,"")}
    v = url.gsub(/^.+v=/,"").gsub(/&.+$/,"")
    tmp = "http://www.youtube.com/get_video?video_id=#{v}&t=#{t}&fmt=#{fmt.to_s}"
    Net::HTTP.start('www.youtube.com',80) do |h|
        vh = h.head("/get_video?video_id=#{v}&t=#{t}&fmt=#{fmt.to_s}")
        if vh.code == "303"
            uri = URI.parse(vh["Location"])
            vh2 = Net::HTTP.start(uri.host,80) do |h2|
                h2.head(uri.path+"?"+uri.query)
            end
            tmp = "http://www.youtube.com/get_video?video_id=#{v}&t=#{t}&fmt=18"if vh2.code == "404"
        elsif vh.code == "404"
            tmp = "http://www.youtube.com/get_video?video_id=#{v}&t=#{t}&fmt=18"
        end
    end
    return tmp
end

cgi = CGI.new
unless cgi.has_key?("v")
    print "Content-Type: text/plain\n\n"
    print "(sun)\n"
    exit
end

puts cgi.header({
    "status" => "302 Found", 'Location' => get_youtube_mp4("http://youtube.com/watch?v=#{cgi["v"]}"), "Content-Type" => "video/mp4"
})
