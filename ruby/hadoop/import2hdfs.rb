#!/opt/ruby/1.9.3/bin/ruby

require 'zipruby'
require 'tempfile'
require 'sysadmin'

class ImportHDFS
  def filelist
    Dir.filelist(ARGV[0], true).each {|f|
      if f =~ /\.zip\Z/
        zip2hdfs(f)
      else
        import2hdfs(f, File.join(ARGV[1], f))
      end
    }
  end

  def import2hdfs(src, dst)
    puts "Importing #{src} #{dst}"
    `hadoop fs -put #{src} #{dst}`
    puts "Done"
  end

  def zip2hdfs(src)
    Zip::Archive.open(src) do |a|
      a.each do |f|
        puts "Extracting #{f.name}"
        tempfile = Tempfile::new(f.name)
        tempfile.print(f.read)
        retries = 0
        target_path = File.join(ARGV[1], File.dirname(src), f.name)
        begin
          import2hdfs(tempfile.path, target_path)
        rescue
          retries += 1
          puts "ErrorCount: #{retries}, Error found in #{target_path}"
          retry if retries <= 3
        end
        tempfile.close
      end
    end
  end
end

if __FILE__ == $0
  unless ARGV[1].nil?
    i = ImportHDFS.new
    i.filelist
  else
    puts "Syntax: import2hdfs zipdir hadoopdir"
    puts "(ex.) $ ruby import2hdfs.rb data test"
  end
end
