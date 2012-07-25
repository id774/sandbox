#!/usr/bin/env ruby

class Reducer
  def self.ipcount
    wordhash = {}
    $stdin.each_line do |line|
      word, count = line.strip.split
      if wordhash.has_key?(word)
        wordhash[word] += count.to_i
      else
        wordhash[word] = count.to_i
      end
    end
    wordhash
  end

  def self.resolve
    resolved = `hive -e 'select ip, host from resolved;'`
  end

  def self.reduce
    wordhash = ipcount
    wordhash.each {|record, count| puts "#{record}\t#{count}"}
  end
end

Reducer.reduce
