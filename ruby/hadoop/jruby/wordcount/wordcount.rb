def setup(conf)
  # setup jobconf
end

def map(key, value, output, reporter)
  # mapper process
  # (wordcount example)
  value.split.each do |word|
    output.collect(word, 1)
  end
end

def reduce(key, values, output, reporter)
  # reducer process
  # (wordcount example)
  sum = 0
  values.each {|v| sum += v }
  output.collect(key, sum)
end

