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

