# -*- coding: utf-8 -*-

class WordCount
  def initialize(args)
    @in_dir = args.shift || "."
    @out_dir = args.shift || "."
    @score_file = args.shift || "score.txt"
    @all = {}
    @score_map = {}
  end

  def main
    read_from_score_file

    Dir.glob(File.join(@in_dir, "*")).each do |filename|
      transform_file(filename) if FileTest.file?(filename)
    end

    write_all('all_words.txt', @all)
    write_all('all_score.txt', @score_map)
  end

  private

  def transform_file(filename)
    read_from_file(filename)
    @hits = sort_hash_by_value_desc(@hits)
    write_file(filename, @hits)
  end

  def write_all(filename, hash)
    sorted_hash = sort_hash_by_value_desc(hash)
    write_file(filename, sorted_hash)
  end

  def sort_hash_by_value_desc(hash)
    hash.sort{|a, b| b[1] <=> a[1]}
  end

  def read_from_score_file
    @score_table = {}
    open(@score_file) do |file|
      file.each_line do |line|
        code, score = line.force_encoding("utf-8").strip.split(' ')
        @score_table[code] = score
      end
    end
    @score_table
  end

  def read_from_file(filename)
    @hits = {}
    open(filename) do |file|
      file.each_line do |line|
        word = line.force_encoding("utf-8").strip.split(',')[0]
        wordcount(word, filename)
        calc_score(word, filename)
      end
    end
    @hits
  end

  def wordcount(word, filename)
    @hits.has_key?(word) ? @hits[word] += 1 : @hits[word] = 1
    @all.has_key?(word) ? @all[word] += 1 : @all[word] = 1
  end

  def calc_score(word, filename)
    basename = File.basename(filename, File.extname(filename))
    magnification = @score_table[basename].to_f
    @score_map.has_key?(word) ? @score_map[word] += magnification : @score_map[word] = magnification
    @score_map[word] = @score_map[word] / @all[word]
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

