# localtime.py: Print the current time in JST
#
# Description:
# Print the current time in JST with an explicit timezone offset.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 localtime.py
#
# Requirements:
# - Python 3.2 or later, which provides datetime.timezone
# - A C library whose strftime supports %s, which the format string uses
#

from datetime import datetime, timedelta, timezone

JST = timezone(timedelta(hours=+9), 'JST')
now = datetime.now(JST).strftime("%Y-%m-%dT%H:%M:%S.%s+09:00")

print(now)
