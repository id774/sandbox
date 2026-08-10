# List the addresses of eth0 with Socket.getifaddrs.

require 'socket'
result = Socket.getifaddrs.select{|x| x.name == "eth0"}
p result
