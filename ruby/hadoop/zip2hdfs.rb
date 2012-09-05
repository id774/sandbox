#!/opt/ruby/1.9.3/bin/ruby

require 'zipruby'
require 'tempfile'
require 'sysadmin'

def unzip(src)
  Zip::Archive.open(src) do |a|
    a.each do |f|
      tempfile = Tempfile::new(f.name)
      tempfile.print(f.read)
      `hadoop fs -put #{tempfile.path} #{ARGV[1]}/#{f.name}`
    end
  end
end

def run
  Dir.filelist(ARGV[0]).each {|f|
    unzip(f)
  }
end

if __FILE__ == $0
  unless ARGV[1].nil?
    run
  else
    puts "Syntax: zip2hdfs zipdir hadoopdir"
  end
end
