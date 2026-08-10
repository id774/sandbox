# Find the last day of the previous month by subtracting one day.

import datetime

date = datetime.date(2015, 1, 1) - datetime.timedelta(days=1)

print(date)
print(date.day)
