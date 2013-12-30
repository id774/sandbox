require 'socket'
result = Socket.getifaddrs.select{|x| x.name == "eth0"}
p result
