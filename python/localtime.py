from datetime import datetime, timedelta, timezone

JST = timezone(timedelta(hours=+9), 'JST')
now = datetime.now(JST).strftime("%Y-%m-%dT%H:%M:%S.%s+09:00")

print(now)
