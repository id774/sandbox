# Object#send

def up_or_down(word, condition)
  up_or_down = condition ? :upcase : :downcase
  word.send(up_or_down)
end

p up_or_down('Ruby', true)
p up_or_down('Ruby', false)

