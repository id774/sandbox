# amazons3_up_and_down.rb: Upload an S3 object and read it back
#
# Description:
# Upload an object to S3 and read it back.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby amazons3_up_and_down.rb
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

puts "--- Upload ---"

object = bucket.objects['test/hoge.txt']
object.write(Pathname.new('test/hoge.txt'))

puts "--- Download ---"

object = bucket.objects['test/hoge.txt']
File.open('test/out.txt', 'wb') do |file|
  object.read do |chunk|
     file.write(chunk)
  end
end

