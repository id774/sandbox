# -*- coding: utf-8 -*-

require 'json'

class Analyzer
  def initialize(args)
    @filename = args.shift || "json.txt"
    @summarized_hash = Hash.new
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        hash = Hash.new
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        JSON.parse(json).each {|word, count|
          hash.has_key?(word) ? hash[word] += count : hash[word] = count
        }
        if @summarized_hash.has_key?(tag)
          addtional_merge(tag, hash)
        else
          @summarized_hash[tag] = hash
        end
      end
    end

    i = 0
    @summarized_hash.each {|k, v|
      i += 1
      output(i, k, v)
    }
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{JSON.generate(value)}"
  end

  def addtional_merge(tag, h)
    h.each {|k, v|
      @summarized_hash[tag].has_key?(k) ? @summarized_hash[tag][k] += v : @summarized_hash[tag][k] = v
    }
  end
end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

