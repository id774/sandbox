# -*- coding: utf-8 -*-

require 'MeCab'

class Extractor
  def initialize(args)
    @in_dir = args.shift || "."
    @out_dir = args.shift || "."

    userdic_path = args.shift || "."
    @userdic = File.expand_path(userdic_path)

    stopwords = args.shift || "stopword.txt"
    @exclude = read_from_exclude(stopwords)

    @mecab = MeCab::Tagger.new("-Ochasen -u #{@userdic}")
  end

  def main
    Dir.glob(File.join(@in_dir, "*")).each do |filename|
      transform_file(filename) if FileTest.file?(filename)
    end
  end

  private

  def transform_file(filename)
    words = read_from_file(filename)
    write_file(filename, words)
  end

  def read_from_file(filename)
    picked_nouns = []
    open(filename) do |file|
      file.each_line do |line|
        line = line.force_encoding("utf-8").strip
        picked_nouns.concat(pickup_nouns(line))
      end
    end
    picked_nouns
  end

  def read_from_exclude(filename)
    exclude = []
    open(filename) do |file|
      file.each_line do |line|
        exclude << line.force_encoding("utf-8").strip.split(",")[0]
      end
    end
    return exclude.sort.uniq
  end

  def write_file(filename, words)
    File.write(
      File.join(@out_dir, File.basename(filename)),
      words.join("\n")
    )
  end

  def pickup_nouns(string)
    node = @mecab.parseToNode(string)
    words = []
    while node
      if /^名詞/ =~ node.feature.force_encoding("utf-8").split(/,/)[0] then
        word = node.surface.force_encoding("utf-8")
        if word.length > 1
          unless @exclude.include?(word)
            if word =~ /[一-龠]/
              words.push(word)
            #elsif word =~ /[あ-ん]/
            #  words.push(word)
            elsif word =~ /[ア-ン]/
              words.push(word)
            elsif word =~ /^[A-Za-z].*/
              words.push(word)
            elsif word =~ /^[Ａ-Ｚａ-ｚ].*/
              words.push(word)
            end
          end
        end
      end
      node = node.next
    end
    words
  end

end

if __FILE__ == $0
  extractor = Extractor.new(ARGV)
  extractor.main
end

