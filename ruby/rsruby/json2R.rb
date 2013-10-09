# -*- coding: utf-8 -*-

require 'json'
require 'rsruby'
#require 'awesome_print'

class Calc
  def initialize(filename, outimage)
    @filename = filename
    @outimage = outimage
  end

  def start
    @x = []
    @y = []
    open(@filename) do |file|
      file.each_line do |line|
        key, tag, json = line.force_encoding("utf-8").strip.split("\t")
        hash = JSON.parse(json)
        hash.each {|k,v|
          if k == "受注予定額"
            if v.nil?
              @x << 0
            else
              @x << v.to_i
            end
          end
          if k == "受注額"
            if v.nil?
              @y << 0
            else
              @y << v.to_i
            end
          end
        }
      end
    end
    r_exec
  end

  private

  def r_exec
    r = RSRuby::instance
    r.eval_R(<<-RCOMMAND)
    x <- c( #{@x.join(",")} )
    y <- c( #{@y.join(",")} )

    png(file="hist_x.png")
    hist(x)
    dev.off()
    png(file="hist_y.png")
    hist(y)
    dev.off()
    png(file="plot.png")
    plot(x, y)
    dev.off()
    RCOMMAND
  end

end

if __FILE__ == $0
  filename = ARGV.shift || "json.txt"
  outimage = ARGV.shift || "out.png"
  calc = Calc.new(filename, outimage)
  calc.start
end

