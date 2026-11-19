# shlex_split.py: Split a command line string with shlex
#
# Description:
# Split a command line string into tokens with shlex, honoring quotes.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 shlex_split.py
#
# Requirements:
# - Python 3
#

import shlex

r = shlex.split('''he said 'you are beautiful!' ''')
print(r)
