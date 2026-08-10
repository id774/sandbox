#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Chain select and map lazily over a range.

p (1..100).lazy.select{|n| n.even?}.map{|n| n.to_s}.each{|s| p s}
