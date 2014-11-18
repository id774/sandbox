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
    array = read_from_file(filename)
    write_file(filename, array)
  end

  def read_from_file(filename)
    array = []
    open(filename) do |file|
      file.each_line do |line|
        label, value = line.force_encoding("utf-8").strip.split(',')
        hash = {"label" => label, "value" => value}
        array << hash if array.length < 20
      end
    end
    array
  end

  def write_file(filename, array)
    json = JSON.generate(array)
    File.write(
      File.join(@out_dir, File.basename(filename)),
      json
    )
  end
end

if __FILE__ == $0
  c = Converter.new(ARGV)
  c.main
end

