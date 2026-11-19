# mypy.py: Type annotations checked by mypy
#
# Description:
# Annotate a function with types so mypy can flag a wrong argument type.
# Running the file prints the result of the well-typed call before reaching
# the call with a wrong argument type.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     mypy mypy.py
#     python3 mypy.py
#
# Requirements:
# - Python 3
# - mypy, for the type check
#

def add(a: int, b: int) -> int:
    return a + b

print(add(2, 3))
print(add("a", 3))
