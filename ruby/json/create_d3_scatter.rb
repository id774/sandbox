# -*- coding: utf-8 -*-

require 'json'

class Converter
  def initialize(args)
    @words_txt = args.shift || "all_words.txt"
    @score_txt = args.shift || "all_score.txt"
    @data_json = args.shift || "data.json"
  end

  def main
    words = read_from_file(@words_txt)
    score = read_from_file(@score_txt)
    array = create_json(words, score)
    write_file(@data_json, array)
  end

  private

  def read_from_file(filename)
    hash = {}
    open(filename) do |file|
      file.each_line do |line|
        word, score = line.force_encoding("utf-8").strip.split(',')
        hash[word] = score
      end
    end
    Hash[hash.sort{|a, b| b[1] <=> a[1]}]
  end

  def create_json(words, score)
    array = []
    words.each {|k, v|
      hash = {}
      hash[:name] = k
      hash[:x_count] = v.to_i
      hash[:y_count] = score[k]
      array << hash
    }
    array
  end

  def write_file(filename, json)
    File.write(
      filename,
      JSON.pretty_generate(json)
    )
  end
end

if __FILE__ == $0
  c = Converter.new(ARGV)
  c.main
end

