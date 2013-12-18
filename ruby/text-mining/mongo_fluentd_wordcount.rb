# -*- coding: utf-8 -*-

require 'date'
require 'time'
require 'mongo'
require 'MeCab'

class WordCount
  def initialize(day = 0)
    @run_date      = Date.today - day
    @pickup_date   = (@run_date - 1).strftime("%Y%m%d")
    puts_with_time("The pick up date is #{@pickup_date}")
    @today         = @run_date.strftime("%Y%m%d")
    @wordcount     = "wordcount_#{@pickup_date}.txt"
    @log_path      = "/home/fluent/.fluent/log"
    @outfile       = File.expand_path(File.join(@log_path, @wordcount))
    @exclude       = "wordcount_exclude.txt"
    @exclude_txt   = File.expand_path(File.join(@log_path, @exclude))

    @mecab = MeCab::Tagger.new("-Ochasen")
    @hits = {}
    @exclude = Array.new
  end

  def run
    puts_with_time('Start wordcount')
    read_from_exclude
    read_from_datasource
    write_result
    puts_with_time('End wordcount')
  end

  private

  def puts_with_time(message)
    fmt = "%Y/%m/%d %X"
    puts "#{Time.now.strftime(fmt)}: #{message.force_encoding("utf-8")}"
  end

  def read_from_exclude
    open(@exclude_txt) do |file|
      file.each_line do |line|
        @exclude << line.force_encoding("utf-8").chomp
      end
    end
    puts_with_time("Exclude word's array is #{@exclude}")
  end

  def read_from_datasource
    exclude_count = 0
    mongo = Mongo::Connection.new('localhost', 27017)
    db = mongo.db('fluentd')
    coll = db.collection('news.feed')
    from = Time.parse(@pickup_date)
    to   = Time.parse(@today)
    coll.find({:time => {"$gt" => from , "$lt" => to}}).each {|line|
      line.each {|k,v|
        if k == "title" or k == "description"
          pickup_nouns(v).each {|word|
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
    }
    puts_with_time("Excluded words count is #{exclude_count}")
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
  day = ARGV.shift || 0; day = day.to_i
  wordcount = WordCount.new(day)
  wordcount.run
end

