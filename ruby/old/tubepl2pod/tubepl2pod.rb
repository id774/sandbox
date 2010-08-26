require "open-uri"
require "rexml/document"
require "cgi"
require "time"
require "rss"

def get_youtube_mp4(url)
    t = open(url) { |h| h.read.gsub(/^.+"t": "/m,"").gsub(/", .+$/m,"")}
    v = url.gsub(/^.+v=/,"").gsub(/&.+$/,"")
    return "http://youtube.com/get_video?video_id=#{v}&t=#{t}&fmt=18"
end

def get_youtube_playlist(plid)
    raw_pl = open("http://gdata.youtube.com/feeds/base/playlists/#{plid}"){|h| h.read}
    xml_pl = REXML::Document.new(raw_pl)
    pl = []
    i = 0
    xml_pl.elements['/feed'].each do |e|
        if e.name == 'entry'
            pl << {
                "title" => e.elements['title'].text,
                "video" => "http://127.0.0.1/podcasts/get_video/"+e.elements['link'].attributes['href'].sub(/^.+v=/,"").sub(/&.+$/,"")+".mp4", #get_youtube_mp4(e.elements['link'].attributes['href']),
                "link" => e.elements['link'].attributes['href'],
                "updated" => Time.now + i,#Time.parse(e.elements['updated'].text),
                "feed_title" => xml_pl.elements['/feed/title'].text,
                "description" => e.elements['content'].text
            }
            i += 1
        end
    end
    return pl
end

def make_podcast(pl)
    items = ""
    return RSS::Maker.make("2.0") do |maker|
        maker.channel.title = pl[0]["feed_title"]
        maker.channel.description = "tubepl2pod.rb"
        maker.channel.link = "http://www.youtube.com/view_play_list?p=#{ARGV[0]}"
        pl.each do |v|
            maker.items.new_item do |item|
                item.link = v["link"]
                item.title = v["title"]
                item.pubDate = v["updated"]
                item.description = v["description"] #"tubepl2pod.rb"
                item.enclosure.url = v["video"]
                item.enclosure.type = "video/mp4"
                item.enclosure.length = 0
            end
        end
    end.to_s.gsub(/length="0"/,"")
end

(puts "usage: tubepl2pod.rb playlist-id";exit) unless ARGV[0]
puts make_podcast(get_youtube_playlist(ARGV[0]))
