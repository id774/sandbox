# -*- coding: utf-8 -*-

require 'rsruby'
require 'awesome_print'

def r_load
  @exam = [13,14,7,12,10,6,8,15,4,14,9,6,10,12,5,12,8,8,12,15]
  r_exec
end

private

def r_exec
  r = RSRuby::instance
  r.eval_R(<<-RCOMMAND)
  exam <- c( #{@exam.join(",")} )

  png(file="out.png")
  hist(exam)
  dev.off()
  exam
RCOMMAND
end

if __FILE__ == $0
  result = r_load
  ap result
end
