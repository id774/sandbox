# -*- coding: utf-8 -*-
# simple_wordcount.rb: Word counts of every file in a directory
#
# Description:
# Count the words of every file in a directory. The input and output
# directories default to the current one.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby simple_wordcount.rb [input directory] [output directory]
#
# Requirements:
# - Ruby
#

class WordCount
  def initialize(args)
    @in_dir = args.shift || "."
    @out_dir = args.shift || "."
    @all = {}
  end

  def main
    Dir.glob(File.join(@in_dir, "*")).each do |filename|
      transform_file(filename) if FileTest.file?(filename)
    end
    @all = sort_hash_by_value_desc(@all)
    write_file('all_words.txt', @all)
  end

  private

  def sort_hash_by_value_desc(hash)
    hash.sort{|a, b| b[1] <=> a[1]}
  end

  def wordcount(word)
    @hits.has_key?(word) ? @hits[word] += 1 : @hits[word] = 1
    @all.has_key?(word) ? @all[word] += 1 : @all[word] = 1
  end

  def transform_file(filename)
    read_from_file(filename)
    @hits = sort_hash_by_value_desc(@hits)
    write_file(filename, @hits)
  end

  def read_from_file(filename)
    @hits = {}
    open(filename) do |file|
      file.each_line do |line|
        word = line.force_encoding("utf-8").strip.split(',')[0]
        wordcount(word)
      end
    end
    @hits
  end

  def write_file(filename, hash)
    open(File.join(@out_dir, File.basename(filename)), "w") {|f|
      hash.each {|k, v|
        f.write "#{k},#{v}\n"
      }
    }
  end
end

if __FILE__ == $0
  wc = WordCount.new(ARGV)
  wc.main
end

