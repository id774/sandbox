
print "byte mac_address[] = { "
6.times do |i|
    print "0x" + rand(255).to_s(16) + (i >= 5 ? " };" : ", ")
end

