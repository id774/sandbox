import re

def to_camel(s):
    return re.sub("_(.)", lambda x: x.group(1).upper(), s)

def to_snake(s):
    return re.sub("([A-Z])", lambda x: "_" + x.group(1).lower(), s)

s = "aaa_bbb_ccc"
print(s)
s = to_camel(s)
print(s)

s = "aaaBbbCcc"
print(s)
s = to_snake(s)
print(s)
