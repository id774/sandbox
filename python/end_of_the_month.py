# end_of_the_month.py: Last day of the previous month
#
# Description:
# Find the last day of the previous month by subtracting one day.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 end_of_the_month.py
#
# Requirements:
# - Python 3
#

import datetime

date = datetime.date(2015, 1, 1) - datetime.timedelta(days=1)

print(date)
print(date.day)
