# -*- coding: utf-8 -*-

require 'json'

class Analyzer
  def initialize(args)
    @filename = args.shift || "category_map.txt"
    @exclude  = args.shift || "wordcount_exclude.txt"
    @hash = Hash.new
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
            unless @exclude.include?(word)
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
    puts "#{@category_num}\t#{category}\t#{hits}"
    return hits
  end

  def start
    @category_num = 0
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

  def puts_with_time(message)
    fmt = "%Y/%m/%d %X"
    puts "#{Time.now.strftime(fmt)}: #{message.force_encoding("utf-8")}"
  end

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
  end
end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

