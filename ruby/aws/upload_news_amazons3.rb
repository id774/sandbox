# -*- coding: utf-8 -*-

require 'json'
require 'date'
require 'aws-sdk'

class HotNews
  def initialize(pickup_date, run_date)
    @pickup_date   = pickup_date
    @run_date      = run_date
    puts_with_time("The pick up date is #{@pickup_date}.")

    @log_name      = "news.log.#{@pickup_date}_0.log"
    @wordcount     = "wordcount_#{@pickup_date}.txt"
    @train         = "train.log.#{@pickup_date}_0.log"
    @hot_news      = "hotnews_#{@pickup_date}.txt"

    @log_path      = "/home/fluent/.fluent/log"

    @log_file      = File.expand_path(File.join(@log_path, @log_name))
    @wordcount_txt = File.expand_path(File.join(@log_path, @wordcount))
    @train_txt     = File.expand_path(File.join(@log_path, @train))
    @news_file     = File.expand_path(File.join(@log_path, @hot_news))

    @s3 = AWS::S3.new(
      :access_key_id => 'XXXXXX',
      :secret_access_key => 'XXXXXX'
    )
    @bucket = @s3.buckets['XXXXXX']
  end

  def run
    upload(@log_file, "news/log/#{@log_name}")
    upload(@wordcount_txt, "news/log/#{@wordcount}")
    upload(@train_txt, "news/log/#{@train}")
    upload(@news_file, "news/log/#{@hot_news}")
  end

  private

  def puts_with_time(message)
    fmt = "%Y/%m/%d %X"
    puts "#{Time.now.strftime(fmt)}: #{message.force_encoding("utf-8")}"
  end

  def upload(filename, bucket)
    object = @bucket.objects[bucket]
    object.write(Pathname.new(filename))
    puts_with_time("Uploaded file #{filename} to the bucket #{bucket}.")
  end
end

if __FILE__ == $0
  pickup_date = ARGV.shift || (Date.today - 1).strftime("%Y%m%d")
  run_date = ARGV.shift || Date.today.strftime("%Y%m%d")
  hot_news = HotNews.new(pickup_date, run_date)
  hot_news.run
end

