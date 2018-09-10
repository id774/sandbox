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
