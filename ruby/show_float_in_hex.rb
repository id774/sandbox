# show_float_in_hex.rb: Byte representation of a float in hexadecimal
#
# Description:
# Print the byte representation of a float in hexadecimal.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby show_float_in_hex.rb
#
# Requirements:
# - Ruby
#

s=[3.14].pack("f"); printf "%02X%02X%02x%02X\n", s[0].ord,s[1].ord,s[2].ord,s[3].ord
sss = [3.14].pack("f").unpack("H*").join
p sss
p "%f" % [sss].pack("H*").unpack("f")
