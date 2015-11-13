# http://qiita.com/yukinoi/items/e521e8f6b085a51de90b

from collections import defaultdict
import unicodedata

ok_chars = defaultdict(list)
ng_chars = defaultdict(list)

for i in range(0x10FFFF):
    if i == 35:  # sharp (#)
        continue
    try:
        exec("%s = 1" % chr(i))
        ok_chars[unicodedata.category(chr(i))].append(chr(i))
    except:
        ng_chars[unicodedata.category(chr(i))].append(chr(i))
        continue

for char_type in (set(ok_chars) | set(ng_chars)):
    print(char_type, len(ok_chars[char_type]), len(ng_chars[char_type]))
