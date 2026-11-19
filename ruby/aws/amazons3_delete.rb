# amazons3_delete.rb: Delete objects from an S3 bucket
#
# Description:
# Delete objects from a placeholder S3 bucket.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby amazons3_delete.rb
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

puts "--- Delete ---"

object = bucket.objects['fuga.txt']
object.delete
object = bucket.objects['test/hoge.txt']
object.delete

