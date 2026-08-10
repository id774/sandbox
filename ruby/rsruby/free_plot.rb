# -*- coding: utf-8 -*-
# Plot two arrays in R through RSRuby.

require 'rsruby'
require 'awesome_print'

def r_load
  @time = [1,3,10,12,6,3,8,4,1,5]
  @test = [20,40,100,80,50,50,70,50,10,60]
  r_exec
end

private

def r_exec
  r = RSRuby::instance
  r.eval_R(<<-RCOMMAND)
  time <- c( #{@time.join(",")} )
  test <- c( #{@test.join(",")} )

  png(file="out.png")
  plot(time, test)
  dev.off()
  time
RCOMMAND
end

if __FILE__ == $0
  result = r_load
  ap result
end
