#!/opt/ruby/1.9.3/bin/ruby

require 'zipruby'
require 'tempfile'
require 'sysadmin'

def lineno(path)
  open(path).each{}.lineno
end

def import2hdfs(src, dst)
  puts "Importing #{src} #{dst}"
  `hadoop fs -put #{src} #{dst}`
  puts "Done"
end

def unzip(src)
  Zip::Archive.open(src) do |a|
    a.each do |f|
      tempfile = Tempfile::new(f.name)
      tempfile.print(f.read)
      #import2hdfs(tempfile.path, File.join(ARGV[1], f.name))
      #puts "%d" % lineno(tempfile.path)
      puts "#{f.name} #{lineno(tempfile.path)}"
      #tempfile.close
    end
  end
end

def run
  Dir.filelist(ARGV[0], true).each {|f|
    if f =~ /\.zip\Z/
      unzip(f)
    else
      puts "#{f} #{lineno(f)}"
    end
  }
end

if __FILE__ == $0
  unless ARGV[0].nil?
    run
  else
    puts "Syntax: wc4zip zipdir"
  end
end
