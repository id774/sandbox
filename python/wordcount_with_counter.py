# wordcount_with_counter.py: Count words with collections.Counter
#
# Description:
# Count word occurrences with collections.Counter.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 wordcount_with_counter.py
#
# Requirements:
# - Python 3
#

from collections import Counter

result = Counter(['a', 'b', 'c', 'a', 'b', 'a']).most_common()
print(result)
