s=[3.14].pack("f"); printf "%02X%02X%02x%02X\n", s[0].ord,s[1].ord,s[2].ord,s[3].ord
p [3.14].pack("f").unpack("H*")
