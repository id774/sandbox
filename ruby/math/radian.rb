#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-


# 30 degrees = pi*30/180 = pi/6; convert degrees to radians
deg = 30
rad = (deg * Math::PI/180.0)

p rad

# pi/6 = pi*30/180 = 30 degrees; convert radians to degrees
rad = 0.5235987755982988
deg = ( rad * 180.0 / Math::PI )

p deg
