# -*- coding: utf-8 -*-
# csv_d3json.rb: Label and value CSV files to d3 JSON
#
# Description:
# Convert label and value CSV files in an input directory into the JSON d3
# expects in an output directory. Both directories default to the current one.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby csv_d3json.rb [input directory] [output directory]
#
# Requirements:
# - Ruby
#

require 'json'

class Converter
  def initialize(args)
    @in_dir = args.shift || "."
    @out_dir = args.shift || "."
  end

  def main
    Dir.glob(File.join(@in_dir, "*")).each do |filename|
      transform_file(filename) if FileTest.file?(filename)
    end
  end

  private

  def transform_file(filename)
    json = read_from_file(filename)
    write_file(filename, json)
  end

  def read_from_file(filename)
    array = []
    open(filename) do |file|
      file.each_line do |line|
        label, value = line.force_encoding("utf-8").strip.split(',')
        hash = {:label => label, :value => value}
        array << hash if array.length < 30
      end
    end
    # [{:key => "key", :values => array}]
    array
  end

  def write_file(filename, json)
    File.write(
      File.join(@out_dir, File.basename(filename)),
      JSON.pretty_generate(json)
    )
  end
end

if __FILE__ == $0
  c = Converter.new(ARGV)
  c.main
end

