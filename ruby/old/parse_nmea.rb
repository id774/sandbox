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
    ary = get_lat_and_lon(str)
    p ary if !ary.nil?
end

