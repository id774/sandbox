# locals.py: Interpolate local variables through locals()
#
# Description:
# Interpolate local variables into strings through the locals() mapping.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 locals.py
#
# Requirements:
# - Python 3
#

a = "hoge"
b = 11
c = True
d = None
e = ["e", 999]
f = {"f": 1}

print("a is %(a)s, b is %(b)s" % locals())

print("c is %(c)s\n\
d is %(d)s" % locals())

print("e is %(e)s, b is %(f)s" % locals())
