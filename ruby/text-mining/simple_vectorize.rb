# -*- coding: utf-8 -*-

class WordCount
  def initialize(args)
    @in_dir = args.shift || "."
    @out_dir = args.shift || "."
    @word_vector = {}
    @all_words = []
  end

  def main
    Dir.glob(File.join(@in_dir, "*")).each do |filename|
      transform_file(filename) if FileTest.file?(filename)
    end
  end

  private

  def vectorize
    @word_vector.each {|filename, words|
      vector = []
      @all_words.each {|word|
        vector << words[word].to_i
      }
      write_file(filename, vector)
    }
  end

  def transform_file(filename)
    read_from_file(filename)
    @all_words = @all_words.sort.uniq
    vectorize
    write_file('all_words.txt', @all_words)
  end

  def read_from_file(filename)
    dic = {}
    open(filename) do |file|
      file.each_line do |line|
        word, count = line.force_encoding("utf-8").strip.split(',')
        dic[word] = count.to_i
      end
    end
    @all_words.concat(dic.keys)
    @word_vector[filename] = dic
  end

  def write_file(filename, vector)
    File.write(
      File.join(@out_dir, File.basename(filename)),
      vector.join(",")
    )
  end
end

if __FILE__ == $0
  wc = WordCount.new(ARGV)
  wc.main
end

