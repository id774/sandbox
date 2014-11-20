# -*- coding: utf-8 -*-

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
    [{:key => "key", :values => array}]
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

