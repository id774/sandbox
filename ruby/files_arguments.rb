# -*- coding: utf-8 -*-

class MainClass
  def initialize(args)
    @infiles = args.shift || ""
  end

  def main
    Dir.glob(@infiles).each do |infile|
      open(infile) do |file|
        p infile
        file.each_line do |line|
        end
      end if FileTest.file?(infile)
    end
  end
end

if __FILE__ == $0
  m = MainClass.new(ARGV)
  m.main
end

