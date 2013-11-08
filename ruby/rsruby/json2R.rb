# -*- coding: utf-8 -*-

require 'json'
require 'rsruby'
#require 'awesome_print'

class Calc
  def initialize(args)
    @filename = args.shift || "json.txt"
    @outimage = args.shift || "out"
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
              @x << v.to_i / 10000
            end
          end
          if k == "売上額"
            if v.nil?
              @y << 0
            else
              @y << v.to_i / 10000
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

    png(file="#{@outimage}_hist_x.png")
    hist(x)
    dev.off()
    png(file="#{@outimage}_hist_y.png")
    hist(y)
    dev.off()
    png(file="#{@outimage}_plot.png")
    plot(x, y)
    dev.off()
    RCOMMAND
  end

end

if __FILE__ == $0
  calc = Calc.new(ARGV)
  calc.start
end

