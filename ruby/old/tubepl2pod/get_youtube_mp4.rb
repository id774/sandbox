require "open-uri"

def get_youtube_mp4(url)
    t = open(url) { |h| h.read.gsub(/^.+"t": "/m,"").gsub(/", .+$/m,"")}
    v = url.gsub(/^.+v=/,"").gsub(/&.+$/,"")
    return "http://youtube.com/get_video?video_id=#{v}&t=#{t}&fmt=18"
end

p get_youtube_mp4("http://www.youtube.com/watch?v=91JdWJ1UtTY&feature=PlayList&p=77AD5CC2DCAB93C4&index=9&fmt=18")
