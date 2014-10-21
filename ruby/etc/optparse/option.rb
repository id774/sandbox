#!/usr/bin/env ruby

require 'optparse'

def main(args, options)
  p args
  p options
end

if __FILE__ == $0
  options = Hash.new
  parser = OptionParser.new do |parser|
    parser.banner = "#{File.basename($0,".*")}
    Usage: #{File.basename($0,".*")} [options] args"
    parser.separator "options:"
    parser.on('-f', '--file FILE', String, "read data from FILENAME"){|f| options['filename'] = f }
    parser.on('-d', '--date DATE', String, "state date is START_DATE"){|d| options['start_date'] = d }
    parser.on('-v', '--verbose', "verbose"){ options['verbose'] = true }
    parser.on('-q', '--quiet', "quiet"){ options['verbose'] = false }
    parser.on('-h', '--help', "show this message"){
      puts parser
      exit
    }
  end

  begin
    parser.parse!
  rescue OptionParser::ParseError => err
    $stderr.puts err.message
    $stderr.puts parser.help
    exit 1
  end

  main(ARGV, options)
end
