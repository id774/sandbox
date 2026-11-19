# camel_snake.py: Convert identifiers between snake case and camel case
#
# Description:
# Convert an identifier between snake case and camel case with regexes.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 camel_snake.py
#
# Requirements:
# - Python 3
#

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
