#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-
# radian.rb: Convert between degrees and radians
#
# Description:
# Convert 30 degrees to radians and pi/6 radians back to degrees, printing
# each result.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby radian.rb
#
# Requirements:
# - Ruby
#


# 30 degrees = pi*30/180 = pi/6; convert degrees to radians
deg = 30
rad = (deg * Math::PI/180.0)

p rad

# pi/6 = pi*30/180 = 30 degrees; convert radians to degrees
rad = 0.5235987755982988
deg = ( rad * 180.0 / Math::PI )

p deg
