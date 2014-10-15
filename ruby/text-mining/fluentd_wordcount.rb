# -*- coding: utf-8 -*-

require 'logger'
require 'json'
require 'date'
require 'MeCab'

class WordCount
  def initialize(pickup_date, run_date)
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO

    @pickup_date   = pickup_date
    @run_date      = run_date
    puts("The pick up date is #{@pickup_date}")
    @log_name      = "news.log.#{@pickup_date}_0.log"
    @wordcount     = "wordcount_#{@pickup_date}.txt"
    @log_path      = "/home/fluent/.fluent/log"
    @infile        = File.expand_path(File.join(@log_path, @log_name))
    @outfile       = File.expand_path(File.join(@log_path, @wordcount))
    @exclude       = "wordcount_exclude.txt"
    @exclude_txt   = File.expand_path(File.join(@log_path, @exclude))

    @mecab = MeCab::Tagger.new("-Ochasen")
    @hits = {}
    @exclude = Array.new
  end

  def run
    puts('Start wordcount')
    read_from_exclude
    read_from_datasource
    write_result
    puts('End wordcount')
  end

  private

  def puts(message, level=:info)
    @logger.send(level, message)
  end

  def read_from_exclude
    open(@exclude_txt) do |file|
      file.each_line do |line|
        @exclude << line.force_encoding("utf-8").chomp
      end
    end
    puts("Exclude word's array is #{@exclude}", level=:debug)
  end

  def read_from_datasource
    links = Array.new
    titles = Array.new
    exclude_count = 0
    open(@infile) do |file|
      file.each do |line|
        hash = JSON.parse(line.force_encoding("utf-8").scan(/\{.*\}/).join)
        unless links.include?(hash['link']) or titles.include?(hash['title'])
          links.push(hash['link'])
          titles.push(hash['title'])
          hash.each {|k,v|
            if k == "title" or k == "description"
              s = ""
              s << v if v.class == String
              pickup_nouns(s).each {|word|
                if word.length > 1
                  if word =~ /[一-龠]/ or word =~ /^[A-Za-z].*/
                    unless @exclude.include?(word)
                      count_words(word)
                    else
                      exclude_count += 1
                    end
                  end
                end
              }
            end
          }
        end
      end
    end
    puts("Excluded words count is #{exclude_count}")
  end

  def write_result
    open(@outfile, "w"){|f|
      i = 0
      @hits.sort_by{|k,v| -v}.each {|k, v|
        i += 1
        f.write("#{i.to_s}\t#{k}\t#{v}\n") if v >= 1
      }
    }
  end

  def count_words(word)
    @hits.has_key?(word) ? @hits[word] += 1 : @hits[word] = 1
  end

  def pickup_nouns(string)
    node = @mecab.parseToNode(string)
    nouns = []
    while node
      if /^名詞/ =~ node.feature.force_encoding("utf-8").split(/,/)[0] then
        nouns.push(node.surface.force_encoding("utf-8"))
      end
      node = node.next
    end
    nouns
  end
end

if __FILE__ == $0
  pickup_date = ARGV.shift || (Date.today - 1).strftime("%Y%m%d")
  run_date = ARGV.shift || Date.today.strftime("%Y%m%d")
  wordcount = WordCount.new(pickup_date, run_date)
  wordcount.run
end

