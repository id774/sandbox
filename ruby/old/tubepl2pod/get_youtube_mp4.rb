# get_youtube_mp4.rb: MP4 download URL for a YouTube video
#
# Description:
# Build the MP4 download URL for a YouTube video.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby get_youtube_mp4.rb
#
# Requirements:
# - Ruby before 3.0, whose Kernel#open still opens URLs through open-uri
#

require "open-uri"

def get_youtube_mp4(url)
    t = open(url) { |h| h.read.gsub(/^.+"t": "/m,"").gsub(/", .+$/m,"")}
    v = url.gsub(/^.+v=/,"").gsub(/&.+$/,"")
    return "http://youtube.com/get_video?video_id=#{v}&t=#{t}&fmt=18"
end

p get_youtube_mp4("http://www.youtube.com/watch?v=91JdWJ1UtTY&feature=PlayList&p=77AD5CC2DCAB93C4&index=9&fmt=18")
