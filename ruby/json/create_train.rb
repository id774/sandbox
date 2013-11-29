# -*- coding: utf-8 -*-

require 'json'
require 'awesome_print'

class Analyzer
  def initialize(args)
    @filename = args.shift || "json.txt"
    @id_count = 1
    @success_count = 0
    @failure_count = 0
  end

  def start
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")

        code, type, project_name = key.strip.split(",")
        action, result = tag.strip.split(",")
        hash = JSON.parse(json)

        if result == '受注' or result == '失注'
          unless hash['words'].nil?
            words = {}
            hash['words'].each do |word|
              words.has_key?(word) ? words[word] += 1 : words[word] = 1
            end
            output(@id_count, result, JSON.generate(words)) if words.length > 0
          end
        end
      end
    end
  end

  private

  def output(key, tag, value)
    puts "#{key}\t#{tag}\t#{value}"
    @id_count += 1
    @success_count += 1 if tag == "受注"
    @failure_count += 1 if tag == "失注"
  end
end

if __FILE__ == $0
  analyzer = Analyzer.new(ARGV)
  analyzer.start
end

