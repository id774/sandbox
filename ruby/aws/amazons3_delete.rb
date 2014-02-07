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

