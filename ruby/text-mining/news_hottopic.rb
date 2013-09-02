# -*- coding: utf-8 -*-

require 'json'
require 'date'
require 'MeCab'
require 'kmeans/pearson'
require 'kmeans/hcluster'
require 'kmeans/dendrogram'
require 'naivebayes'

class HotNews
  def initialize(day = 0)
    @run_date      = Date.today - day
    @pickup_date   = (@run_date - 1).strftime("%Y%m%d")
    puts_with_time("The pick up date is #{@pickup_date}")
    @log_name      = "news.log.#{@pickup_date}_0.log"
    @wordcount     = "wordcount_#{@pickup_date}.txt"
    @train         = "train.log.#{@pickup_date}_0.log"
    @hot_news      = "hotnews_#{@pickup_date}.txt"
    @image_file    = "tree_#{@pickup_date}.png"
    @log_path      = "/home/fluent/.fluent/log"
    @image_path    = "/var/www/rails/news_cloud/public/images"
    @wordcount_txt = File.expand_path(File.join(@log_path, @wordcount))
    @train_txt     = File.expand_path(File.join(@log_path, @train))
    @infile        = File.expand_path(File.join(@log_path, @log_name))
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
    read_from_exclude
    train_from_datasource
  end

  def run
    puts_with_time('Start hotnews')
    read_from_wordcount
    read_from_datasource
    @entry_list = new_entrylist
    write_hotnews
    puts_with_time('Create vector')
    create_wordvector_from_bloghash
    puts_with_time('Start kmeans')
    kmeans_clustering
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

  def train(category)
    hits = {}
    exclude_count = 0
    open(@train_txt) do |file|
      file.each_line do |line|
        datetime, tag, json = line.force_encoding("utf-8").strip.split("\t")
        if tag == category
          JSON.parse(json.force_encoding("utf-8"), {:symbolize_names => true}).each {|k,v|
            if k == :title or k == :description
              pickup_nouns(v).each {|word_raw|
                word = word_raw.force_encoding("utf-8")
                if word.length > 1
                  if word =~ /[亜-腕]/
                    unless @exclude.include?(word)
                      hits.has_key?(word) ? hits[word] += 1 : hits[word] = 1
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
    puts_with_time("Excluded words count is #{exclude_count}")
    puts_with_time("Training classifier #{category} to #{hits}")
    return hits
  end

  def train_from_datasource
    @classifier.train("social", train('category.social'))
    @classifier.train("politics", train('category.politics'))
    @classifier.train("international", train('category.international'))
    @classifier.train("economics", train('category.economics'))
    @classifier.train("electro",  train('category.electro'))
    @classifier.train("sports",  train('category.sports'))
    @classifier.train("entertainment",  train( 'category.entertainment'))
    @classifier.train("science",  train('category.science'))
  end

  def read_from_datasource
    open(@infile) do |file|
      file.each do |line|
        blog = JSON.parse(line.force_encoding("utf-8").scan(/\{.*\}/).join, {:symbolize_names => true})
        hits = {}
        pickup_nouns(blog[:title] + blog[:description]).each {|word|
          if word.length > 1
            if word =~ /[亜-腕]/
              hits.has_key?(word) ? hits[word] += 1 : hits[word] = 1
              if @text_hash.has_key?(word)
                scoring(blog[:title],
                        blog[:link],
                        blog[:description],
                        @text_hash[word])
              end
            end
          end
        }
        @blog_hash[blog[:link]]['category'] = @classifier.classify(hits).max{|a, b| a[1] <=> b[1]}[0] if @blog_hash.has_key?(blog[:link])
      end
    end
  end

  def scoring(title, link, description, count)
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
        i = i + 1
        f.write("#{i.to_s}\t#{v['score'].to_s}\t#{v['title']}\t#{k}\t#{v['category']}\n")
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
      entry_list << v['title']
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
  day = ARGV.shift || 0; day = day.to_i
  hot_news = HotNews.new(day)
  hot_news.run
end

