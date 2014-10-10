# -*- coding: utf-8 -*-

require 'logger'
require 'date'
require 'time'
require 'mongo'
require 'MeCab'
require 'kmeans/pearson'
require 'kmeans/hcluster'
require 'kmeans/dendrogram'
require 'naivebayes'

class HotNews
  def initialize(pickup_date, run_date)
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO

    @pickup_date   = pickup_date
    @run_date      = run_date
    puts("The pick up date is #{@pickup_date}")
    @wordcount     = "wordcount_#{@pickup_date}.txt"
    @train         = "category_map.txt"
    @hot_news      = "hotnews_#{@pickup_date}.txt"
    @image_file    = "tree_#{@pickup_date}.png"
    @log_path      = "/home/fluent/.fluent/log"
    @image_path    = "/var/www/rails/news_cloud/public/images"
    @wordcount_txt = File.expand_path(File.join(@log_path, @wordcount))
    @train_txt     = File.expand_path(File.join(@log_path, @train))
    @outfile       = File.expand_path(File.join(@log_path, @hot_news))
    @outimage      = File.expand_path(File.join(@image_path, @image_file))
    @words         = 150
    @exclude       = "wordcount_exclude.txt"
    @exclude_txt   = File.expand_path(File.join(@log_path, @exclude))

    @mecab = MeCab::Tagger.new("-Ochasen")
    @text_hash = Hash.new
    @blog_hash = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }
    @word_vector = Array.new
    @exclude = Array.new
    @classifier = NaiveBayes::Classifier.new(:model => "multinomial")
    mongo = Mongo::Connection.new('localhost', 27017)
    @db = mongo.db('fluentd')
    read_from_exclude
    train_from_datasource
  end

  def run
    puts('Start hotnews')
    read_from_wordcount
    read_from_datasource
    @entry_list = new_entrylist
    write_hotnews
    puts('Create vector')
    create_wordvector_from_bloghash
    puts('Start kmeans')
    kmeans_clustering
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

  def train(category)
    hits = {}
    exclude_count = 0
    open(@train_txt) do |file|
      file.each_line do |line|
        word, counts, social, politics, international, economics, electro, sports, entertainment, science, standard_deviation = line.force_encoding("utf-8").strip.split("\t")
        array = [social.to_i, politics.to_i, international.to_i, economics.to_i, electro.to_i, sports.to_i, entertainment.to_i, science.to_i]
        unless array[@train_num].to_i == 0
          #if array.max < 100
          #if counts.to_i == array.max or standard_deviation.to_f < 0.4
          if standard_deviation.to_f < 10.0
            unless @exclude.include?(word)
              if word =~ /[一-龠]/
                hits.has_key?(word) ? hits[word] += array[@train_num].to_i * 3 : hits[word] = array[@train_num].to_i * 3
              elsif word =~ /^[A-Za-z].*/
                hits.has_key?(word) ? hits[word] += array[@train_num].to_i : hits[word] = array[@train_num].to_i
              end
            end
          end
        end
      end
    end
    @train_num += 1
    puts("Excluded words count is #{exclude_count}", level=:debug)
    puts("Training classifier #{category} to #{hits}", level=:debug)
    return hits
  end

  def train_from_datasource
    @train_num = 0
    @classifier.train("social", train('category.social'))
    @classifier.train("politics", train('category.politics'))
    @classifier.train("international", train('category.international'))
    @classifier.train("economics", train('category.economics'))
    @classifier.train("electro",  train('category.electro'))
    @classifier.train("sports",  train('category.sports'))
    @classifier.train("entertainment",  train('category.entertainment'))
    @classifier.train("science",  train('category.science'))
  end

  def read_from_datasource
    links = Array.new
    titles = Array.new
    coll = @db.collection('news.feed')
    from = Time.parse(@pickup_date)
    to   = Time.parse(@run_date)
    coll.find({:time => {"$gt" => from , "$lt" => to}}).each {|blog|
      hits = {}
      unless links.include?(blog['link']) or titles.include?(blog['title'])
        links.push(blog['link'])
        titles.push(blog['title'])
        pickup_nouns(blog['title'] + blog['description']).take(15).each {|word|
          if word.length > 1
            if word =~ /[一-龠]/
              hits.has_key?(word) ? hits[word] += 3 : hits[word] = 3
            elsif word =~ /^[A-Za-z].*/
              hits.has_key?(word) ? hits[word] += 1 : hits[word] = 1
            end
            if @text_hash.has_key?(word)
              mongo_scoring(blog['title'],
                            blog['link'],
                            blog['description'],
                            @text_hash[word])
            end
          end
        }
        @blog_hash[blog['link']]['category'] = @classifier.classify(hits).max{|a, b| a[1] <=> b[1]}[0] if @blog_hash.has_key?(blog['link'])
    }
  end

  def mongo_scoring(title, link, description, count)
    if @blog_hash.has_key?(link)
      @blog_hash[link]['score'] += count.to_i
    else
      @blog_hash[link]['title'] = title
      @blog_hash[link]['score'] = count.to_i
      @blog_hash[link]['description'] = description
    end
  end

  def read_from_wordcount
    open(@wordcount_txt) do |file|
      file.each_line do |line|
        num, word, count = line.force_encoding("utf-8").strip.split("\t")
        @text_hash[word] = count if count.to_i >= 1
      end
    end
  end

  def write_hotnews
    open(@outfile, "w"){|f|
      i = 0
      @blog_hash.sort_by{|k,v| -v['score']}.each {|k, v|
        i += 1
        title = v['title'].delete("\t").delete("\n")
        f.write("#{i.to_s}\t#{v['score'].to_s}\t#{title}\t#{k}\t#{v['category']}\n") if v['score'] >= 10
      }
    }
  end

  def create_wordvector_from_bloghash
    @entry_list.each {|entry|
      i = 0
      wordmap = new_wordmap
      @text_hash.keys.each {|word|
        if i < @words
          @blog_hash.each {|k,v|
            if v['title'] == entry
              if (v['title'] + v['description']).include?(word)
                wordmap[i] += 1
              end
            end
          }
          i += 1
        end
      }
      @word_vector << wordmap
    }
  end

  def kmeans_clustering
    cluster = Kmeans::HCluster.new
    hcluster = cluster.hcluster(@word_vector)
    # p cluster.printclust(hcluster, @entry_list)
    den = Kmeans::Dendrogram.new(:imagefile => @outimage)
    den.drawdendrogram(hcluster, @entry_list)
  end

  def new_entrylist
    entry_list = Array.new
    @blog_hash.each {|k,v|
      entry_list << v['title'] if v['score'] >= 10
    }
    entry_list
  end

  def new_wordmap
    wordmap = []
    @words.times do
      wordmap << 0
    end
    wordmap
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
  hot_news = HotNews.new(pickup_date, run_date)
  hot_news.run
end

