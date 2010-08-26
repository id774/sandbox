1.upto(1000) do |n|
    tmp = 0
    n.to_s.each_char{|n|tmp += n.to_i}
    str = "#{'fizz ' if /(0|5)/ =~ n.to_s[-1]}#{'buzz' if tmp == 3}"
    puts str if '' != str
    puts n.to_s if '' == str
 end
