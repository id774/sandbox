# unixtime.py: Convert a Unix timestamp to local and UTC datetimes
#
# Description:
# Convert a Unix timestamp to both local and UTC datetimes.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 unixtime.py
#
# Requirements:
# - Python 3
#

from datetime import datetime

unixtime = 1420911200

loc = datetime.fromtimestamp(unixtime)
timestamp = loc.strftime("%Y-%m-%dT%H:%M:%S.%s+09:00")
print(timestamp)
print(loc.timestamp())

loc = datetime.utcfromtimestamp(unixtime)
timestamp = loc.strftime("%Y-%m-%dT%H:%M:%S.%s+00:00")
print(timestamp)
print(loc.timestamp())
