#!/opt/ruby/1.9.3/bin/ruby
# -*- coding: utf-8 -*-

require 'zipruby'
require 'enumerable/lazy' unless /^2\.0\./ =~ RUBY_VERSION

class Analyzer
  def parse(date)
    path1="/home/debian/tmp/a.zip"
    path2="/home/debian/tmp/b.log"
    (parse_path(path1) + parse_path(path2)).each_line.map {|line|
      print line
    }
  end

  def parse_path(f)
    puts "Reading #{f}"
    if f =~ /\.zip\Z/
      return parse_zip(f)
    else
      return File.open(f).read
    end
  end

  def parse_zip(path)
    Zip::Archive.open(path) do |a|
      a.each do |f|
        puts "Extracting #{f.name}"
        return f.read
      end
    end
  end
end

if __FILE__ == $0
  unless ARGV[0].nil?
    analyzer = Analyzer.new
    analyzer.parse(ARGV[0])
  end
end
