require 'date'
cet_date_time = DateTime.strptime('2015-11-12 CET', '%Y-%m-%d %Z')
p cet_date_time.to_time.to_s

cet_time = Time.new(2005, 2, 21, 10, 11, 12, '+01:00')
p cet_time.to_time.to_s
