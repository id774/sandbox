# series_to_dict.py: Convert a Series into a dict
#
# Description:
# Convert a Series back into a plain dict.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 series_to_dict.py
#
# Requirements:
# - Python 3
# - pandas
#

import pandas as pd

mapping = {"a": "red", "b": "red", "c": "blue", "d": "blue", "e": "red", "f": "orange"}
result = pd.Series(mapping).to_dict()
print(result)
