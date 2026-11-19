# gps_map.rb: Map URLs for NMEA positions
#
# Description:
# Parse NMEA sentences from standard input and print a Google Maps URL for
# each resulting position.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     <NMEA source> | ruby gps_map.rb
#
# Requirements:
# - Ruby
#

def get_lat_and_lon(nmea)
    return nil unless /GGA,/ =~ nmea
    nary = nmea.split(/,/)
    latitude_a = (nary[2].to_f / 100).to_i
    latitude_b = nary[2].to_f - latitude_a * 100
    latitude = latitude_a + latitude_b / 60
    latitude *= -1 if nary[3] == 'S'
    longitude_a = (nary[4].to_f / 100).to_i
    longitude_b = nary[4].to_f - longitude_a * 100
    longitude = longitude_a + longitude_b / 60
    longitude *= -1 if nary[5] == 'W'
    return false if latitude == 0.0 || longitude == 0.0
    return [latitude,longitude]
end

str = ""
while str = gets.chomp!
    flag = false
    ary = get_lat_and_lon(str)
    flag = true if ary.nil?
    puts "http://maps.google.com/maps/?ll=#{ary[0].to_s},#{ary[1].to_s}" unless flag
    puts "x = "+ary[0].to_s+";"+" y = "+ary[1].to_s+";" unless flag
    sleep 1 unless flag
end

