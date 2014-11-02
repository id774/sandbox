# -*- coding: utf-8 -*-

require 'MeCab'
require 'awesome_print'

class Extractor
  def initialize(args)
    @mecab = MeCab::Tagger.new("-Ochasen")
    @in_dir = args.shift || "."
    @out_dir = args.shift || "."
  end

  def main
    Dir.glob(File.join(@in_dir, "*")).each do |infile|
      if FileTest.file?(infile)
        p infile
        picked_nouns = []
        open(infile) do |file|
          file.each_line do |line|
            line = line.force_encoding("utf-8").strip
            picked_nouns.concat(pickup_nouns(line))
          end
        end
        File.write(
          File.join(@out_dir, File.basename(infile)),
          picked_nouns.join("\n")
        )
      end
    end
  end

  private

  def pickup_nouns(string)
    node = @mecab.parseToNode(string)
    nouns = []
    while node
      if /^名詞/ =~ node.feature.force_encoding("utf-8").split(/,/)[0] then
        element = node.surface.force_encoding("utf-8")
        nouns.push(element) if element.length > 1
      end
      node = node.next
    end
    nouns
  end

end

if __FILE__ == $0
  extractor = Extractor.new(ARGV)
  extractor.main
end

