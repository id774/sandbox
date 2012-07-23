def setup(conf)
end

def map(key, value, output, reporter)
  value.split.each do |elm|
    output.collect(elm, 1)
  end
end

def reduce(key, values, output, reporter)
  sum = 0
  values.each {|v| sum += v }
  output.collect(key, sum)
end
