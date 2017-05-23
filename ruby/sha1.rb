#!/usr/bin/env ruby

require 'digest/sha1'

def compute_sha1(str)
  puts Digest::SHA1.hexdigest(str)
end

if __FILE__ == $0
  str=ARGV.shift || "test";
  compute_sha1(str)
end

