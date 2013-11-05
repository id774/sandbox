require 'awesome_print'

def open_file(file = 'json.txt', &block)
  open(file) do |file|
    file.each_line do |line|
      block.call(line)
    end
  end
end

json = []
hash = {}

split_line = lambda {|line|
  hash['key'], hash['tag'], hash['value'] = line.strip.split("\t")
  json << hash
}

open_file("json.txt", &split_line)

ap json
