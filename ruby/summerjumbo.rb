# summerjumbo.rb: Simulate a Summer Jumbo lottery draw
#
# Description:
# Draw a random number below ten million and print, in Japanese, which prize
# tier of the Summer Jumbo lottery it falls into.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby summerjumbo.rb
#
# Requirements:
# - Ruby
#

# One in ten million
n = rand(10000000)

# The first prize number
a = 4012760

if n == a
  p "1 等当たりです！！！！！"
  p "あなたの番号は #{n} です。当たりは #{a} です。"
  p "5 億円当たりました"
elsif n < 4
  p "2 等当たりです！！！！"
  p "あなたの番号は #{n} です。当たりは #{a} です。"
  p "1,000 万円当たりました"
elsif n < 1000
  p "3 等当たりです！！！"
  p "あなたの番号は #{n} です。当たりは #{a} です。"
  p "10 万円当たりました"
elsif n < 1000
  p "4 等当たりです！"
  p "あなたの番号は #{n} です。当たりは #{a} です。"
  p "3,000 円当たりました"
elsif n < 1000000
  p "5 等当たりです"
  p "あなたの番号は #{n} です。当たりは #{a} です。"
  p "300 円当たりました"
else
  p "あなたの番号は #{n} です。当たりは #{a} です。"
  p "はずれです"
end
