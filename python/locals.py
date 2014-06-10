a = "hoge"
b = 11
c = True
d = None
e = ["e",999]
f = {"f":1}

print("a is %(a)s, b is %(b)s" %locals() )

print("c is %(c)s\n\
d is %(d)s" %locals() )

print("e is %(e)s, b is %(f)s" %locals() )

