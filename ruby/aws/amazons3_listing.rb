# amazons3_listing.rb: List S3 buckets and objects
#
# Description:
# List the buckets and objects held in S3.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby amazons3_listing.rb
#
# Requirements:
# - Ruby
# - The aws-sdk gem version 1, which provides AWS::S3
# - AWS credentials and a real bucket name in place of the placeholders
#

require 'aws-sdk'

s3 = AWS::S3.new(
  :access_key_id => 'XXXXXX',
  :secret_access_key => 'XXXXXX'
)

bucket = s3.buckets['XXXXXX']

s3.buckets.each do |bucket|
  puts "Target Bucket is #{bucket.name}."
end

puts "--- Listing ---"

tree = bucket.as_tree

puts "-- Directories --"

directories = tree.children.select(&:branch?).collect(&:prefix)
directories.each{|directory|
  puts directory
}

puts "-- Files --"

files = tree.children.select(&:leaf?).collect(&:key)
files.each{|file|
  puts file
}

puts "-- Keys --"

keys = bucket.objects.collect(&:key)
keys.each{|key|
  puts key
}

puts "-- SubDirs --"

tree = bucket.as_tree({:prefix => 'test/'})
files = tree.children.select(&:leaf?).collect(&:key)
files.each{|file|
  puts file
}
