# -*- coding: utf-8 -*-

require 'json'

class Analyzer
  def initialize(args)
    @filename = args.shift || "category_map.txt"
    @exclude  = args.shift || "wordcount_exclude.txt"
    @category_num = 0
    read_from_exclude
  end

  def extract_map(category)
    hits = {}
    exclude_count = 0
    open(@filename) do |file|
      file.each_line do |line|
        word, counts, social, politics, international, economics, electro, sports, entertainment, science, standard_deviation = line.force_encoding("utf-8").strip.split("\t")
        array = [social.to_i, politics.to_i, international.to_i, economics.to_i, electro.to_i, sports.to_i, entertainment.to_i, science.to_i]
        unless array[@category_num].to_i == 0
          #if array.max < 100
          #if counts.to_i == array.max or standard_deviation.to_f < 0.4
          if standard_deviation.to_f < 10.0
            unless @exclude_words.include?(word)
              if word =~ /[一-龠]/
                hits.has_key?(word) ? hits[word] += array[@category_num].to_i * 3 : hits[word] = array[@category_num].to_i * 3
              elsif word =~ /^[A-Za-z].*/
                hits.has_key?(word) ? hits[word] += array[@category_num].to_i : hits[word] = array[@category_num].to_i
              end
            end
          end
        end
      end
    end
    @category_num += 1
    output(@category_num, category, hits)
    return hits
  end

  def start
    extract_map('category.social')
    extract_map('category.politics')
    extract_map('category.international')
    extract_map('category.economics')
    extract_map('category.electro')
    extract_map('category.sports')
    extract_map('category.entertainment')
    extract_map('category.science')
  end

  private

  def read_from_exclude
    @exclude_words = Array.new
    open(@exclude) do |file|
      file.each_line do |line|
        @exclude_words << line.force_encoding("utf-8").chomp
      end
    end
  end

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{JSON.generate(value, opts = {:space => ' ', :indent => ' '})}"
  end
end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

