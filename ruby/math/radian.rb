#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-


# 角30°= π・30/180 = π・1/6 度をラジアンに変換
deg = 30
rad = (deg * Math::PI/180.0)

p rad

# π・1/6 = π・30/180 = 角30°ラジアンを度に変換
rad = 0.5235987755982988
deg = ( rad * 180.0 / Math::PI )

p deg
