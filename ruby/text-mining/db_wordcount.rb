# -*- coding: utf-8 -*-

require 'logger'
require 'json'
require 'date'
require 'MeCab'
require 'active_record'

class News < ActiveRecord::Base
  self.table_name = 'd'

  def self.today
    date_limit = Date.today.strftime("%Y/%m/%d")
    where("created_at >= ?", date_limit)
  end
end

class WordCount
  def initialize(pickup_date, run_date)
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO

    @pickup_date   = pickup_date
    @run_date      = run_date
    puts("The pick up date is #{@pickup_date}")
    puts("The run date is #{@run_date}")
    @wordcount     = "wordcount_#{@pickup_date}.txt"
    @log_path      = "/home/fluent/.fluent/log"
    @db_path       = "/home/fluent/.fluent/db"
    @outfile       = File.expand_path(File.join(@log_path, @wordcount))
    @exclude       = "wordcount_exclude.txt"
    @exclude_txt   = File.expand_path(File.join(@log_path, @exclude))

    @mecab = MeCab::Tagger.new("-Ochasen")
    @hits = {}
    @exclude = Array.new
    @exclude_count = 0
  end

  def run
    puts('Start wordcount')
    prepare_database
    read_from_exclude
    read_from_datasource
    write_result
    puts('End wordcount')
  end

  private

  def puts(message, level=:info)
    @logger.send(level, message)
  end

  def model_class
    News
  end

  def prepare_database
    db = File.join(@db_path, 'news.db')
    ActiveRecord::Base.establish_connection(
      :adapter  => "sqlite3",
      :database => db
    )
    create_table unless model_class.table_exists?
  end

  def read_from_exclude
    open(@exclude_txt) do |file|
      file.each_line do |line|
        @exclude << line.force_encoding("utf-8").chomp
      end
    end
    puts("Exclude word's array is #{@exclude}", level=:debug)
  end

  def try_pickup_words(sentence)
    if sentence.class == String
      pickup_nouns(sentence).each {|word|
        if word.length > 1
          if word =~ /[一-龠]/ or word =~ /^[A-Za-z].*/
            unless @exclude.include?(word)
              count_words(word)
            else
              @exclude_count += 1
            end
          end
        end
      }
    end
  end

  def read_from_datasource
    links = Array.new
    titles = Array.new
    news_records = model_class.today
    puts("Today's news count is #{news_records.length}")
    news_records.each do |news|
      unless links.include?(news.link) or titles.include?(news.title)
        links.push(news.link)
        titles.push(news.title)
        try_pickup_words(news.title)
        try_pickup_words(news.description)
      end
    end
    puts("Excluded words count is #{@exclude_count}")
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
  pickup_date = ARGV.shift || (Date.today - 0).strftime("%Y%m%d")
  run_date = ARGV.shift || Date.today.strftime("%Y%m%d")
  wordcount = WordCount.new(pickup_date, run_date)
  wordcount.run
end

