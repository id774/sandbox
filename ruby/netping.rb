require 'net/ping'
 
addr = '172.16.xxx.xxx'
 
pingmon = Net::Ping::External.new(
  host = addr,
  timeout = 5
)

if pingmon.ping?
  puts 'reachable.'
else
  puts 'unreachable.'
end
