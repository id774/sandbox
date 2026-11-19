# namedtuple.py: Read namedtuple fields by name
#
# Description:
# Build a namedtuple and read its fields by name.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 namedtuple.py
#
# Requirements:
# - Python 3
#

from collections import namedtuple

Doc = namedtuple('Doc', 'tf idf')
doc = Doc(tf=0.1, idf=0.01)

print(doc.tf, doc.idf)
