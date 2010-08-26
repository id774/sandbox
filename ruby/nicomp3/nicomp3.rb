#-*- coding:utf-8 -*-

# nicomp3.rb
# Author: Sora Harakami <sora134[a,t]gmail.com>
# Licence: MIT Licence
# The MIT Licence {{{
#    Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software and associated documentation files (the "Software"), to deal
#    in the Software without restriction, including without limitation the rights
#    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#    copies of the Software, and to permit persons to whom the Software is
#    furnished to do so, subject to the following conditions:
#
#    The above copyright notice and this permission notice shall be included in
#    all copies or substantial portions of the Software.
#
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#    THE SOFTWARE.
#}}}

require 'rubygems'
require 'nicovideo'
require 'yaml'
require 'fileutils'
require 'id3lib'

abort "Usage: #{File.basename(__FILE__)} config_file" unless ARGV[0]

config = YAML.load_file(ARGV[0])
nv = Nicovideo.new(config["mail"], config["password"])
ffmpeg = config["ffmpeg"] || "ffmpeg"
nul = /mswin/u =~ RUBY_PLATFORM ? 'NUL' : '/dev/null'

if File.exist?(File.expand_path(config["tmpdir"]))
  puts "Wiping tmp directory"
  FileUtils.remove_entry_secure(File.expand_path(config["tmpdir"]))
end
FileUtils.mkdir(File.expand_path(config["tmpdir"]))

if File.exist?(File.expand_path(config["mp3dir"]))
  puts "Wiping mp3 directory"
  deleted = []
  if File.exist?("#{File.expand_path(config["mp3dir"])}/nicomp3_files")
     deleted =   open("#{File.expand_path(config["mp3dir"])}/nicomp3_files"){|f|f.readlines}.map(&:chomp) \
               - Dir.glob("#{File.expand_path(config["mp3dir"])}/*.mp3") \
                    .map{|f| f.gsub(/.+?\/[0-9]+_(.+[0-9]+)_.+\.mp3$/){$1} } \
  end
  if File.exist?("#{File.expand_path(config["mp3dir"])}/nicomp3_deleted")
    deleted << open("#{File.expand_path(config["mp3dir"])}/nicomp3_deleted"){|f|f.readlines}.map(&:chomp)
  end
  open("#{File.expand_path(config["mp3dir"])}/nicomp3_deleted","w"){|f| f.print deleted.join("\n")}

  FileUtils.mv(Dir.glob("#{File.expand_path(config["mp3dir"])}/*.mp3"),File.expand_path(config["tmpdir"]))
end
nv.agent.set_proxy(config["proxy"]["host"],config["proxy"]["port"]) if config["proxy"]

max = config["max"] ? config["max"].to_i : 10

vocaloids = ["初音ミク",
             "鏡音リン",
             "鏡音レン",
             "巡音ルカ",
             "KAITO",
             "MEIKO",
             "重音テト",
             "GUMI",
             "めぐっぽいど",
             "Megpoid",
             "がくっぽいど",
             "がくぽ"]
vocaloids_aliases = {"Megpoid" => "GUMI",
                     "めぐっぽいど" => "GUMI",
                     "がくぽ" => "神威がくぽ",
                     "がくっぽいど" => "神威がくぽ"}

vocaloids_sorting = {"初音ミク" => "Hatune Miku",
                     "鏡音リン" => "Kagamine Rin",
                     "鏡音レン" => "Kagamine Ren",
                     "巡音ルカ" => "Megurine Ruka",
                     "KAITO" => "Kaito",
                     "MEIKO" => "Meiko",
                     "重音テト" => "Kasane Teto",
                     "GUMI" => "Gumi",
                     "神威がくぽ" => "Kamui Gakupo"}

puts "Loading list..."
puts ""

case config["from"]
when nil, "ranking"
  config["option"] ||= {}
  config["option"]["method"] ||= config["method"]||'fav'
  config["option"]["span"] ||= config["span"]||'daily'
  config["option"]["category"] ||= config["category"]||'vocaloid'
  videos = nv.ranking(config["option"]["method"],
                      config["option"]["span"],
                      config["option"]["category"])
else
  videos = []
end

videos[0..max].each_with_index do |v, i|
  puts "#{i+1} (#{v.video_id}): #{v.title.toutf8}"
  if v.type != 'swf' && !deleted.include?(v.video_id)
    basename = "#{i+1}_#{v.video_id}_#{v.title.toutf8}.mp3"
    filename = "#{File.expand_path(config["mp3dir"])}/#{basename}"
    tmpname = "#{File.expand_path(config["tmpdir"])}/#{v.video_id}.#{v.type}"
    thumbname = "#{File.expand_path(config["tmpdir"])}/#{v.video_id}.jpg"

    exist_in_tmp = Dir.glob("#{File.expand_path(config["tmpdir"])}/*_#{v.video_id}_*.mp3")[0]

    if exist_in_tmp
      puts "  Convert is not needed."
      print "  Moving from tmpdir..."
      FileUtils.mv(exist_in_tmp, filename)
      puts " done!"
    else
      print "  Saving video... "
        open(tmpname,"wb") do |f|
          f.print v.video
        end
      puts "done!" 

      puts "--------- Start Converting ---------"
        system("#{ffmpeg}", "-ab", "320", "-i", tmpname, "#{filename}")
      puts "---------      Done!       ---------"

      print "  Detecting Artists..."
        vt = v.title.toutf8
        artists = vocaloids.inject([]){|r,i| vt.include?(i) ? r << i : r }
                           .map!{|i| vocaloids_aliases.key?(i) ? vocaloids_aliases[i] : i }
        artist_sorting = artists.map{|i| vocaloids_sorting.key?(i) ? vocaloids_sorting[i] : i}.join(', ')
        artists = artists.join(', ')
      puts " done!"
      puts "    #{artists}"
      puts "    #{artist_sorting}" 
      
      print "  Exporting thumbnail..."
        system("#{ffmpeg}", "-ss", "10", "-vframes", "50", "-i", tmpname, "-f", "image2", thumbname, :out => nul, :err => nul)
      puts " done!"

      print "  Setting to ID3 Tags..."
      begin
        tag = ID3Lib::Tag.new(filename)
        tag << {:id => :TPE1, :text => artists.toutf16, :textenc => 1}
        tag << {:id => :TALB, :text => vt.toutf16, :textenc => 1}
        tag << {:id => :TIT2, :text => vt.toutf16, :textenc => 1}
        tag << {
          :id => :APIC,
          :mimetype => 'image/jpeg',
          :picturetype => 3,
          :description => '',
          :textenc => 0,
          :data => File.open(thumbname, "rb").read
        }
        tag.update!
        system("eyeD3", "--set-text-frame=TSOP:#{artist_sorting}", filename, :out => nul, :err => nul) rescue nil
      rescue; p $!;end
      puts " done!"
    end
  else
    puts "  Skipped"
  end
  print "Waiting"
  10.times {print "."; sleep 1}
  puts "\n\n"
end

puts "Writing files..."
open("#{File.expand_path(config["mp3dir"])}/nicomp3_files","w") do |f|
  f.print Dir.glob("#{File.expand_path(config["mp3dir"])}/*.mp3") \
             .map{|f| f.gsub(/.+?\/[0-9]+_(.+[0-9]+)_.+\.mp3$/){$1} } \
             .join("\n")
end


puts "Wiping tmp directory"
FileUtils.remove_entry_secure(File.expand_path(config["tmpdir"]))

puts "Exiting...."
