#! /opt/ruby/1.8.7/bin/ruby
# -*- coding: utf-8 -*-

require "rubygems"
require "tmail"

TMail.KCODE='EUC'
mail = TMail::Mail.new

mail.date = Time.now
mail.mime_version = "1.0"
mail.set_content_type "text", "plain", {"charset"=>"iso-2022-jp"}
mail.transfer_encoding = "7bit"
mail.message_id = TMail.new_message_id("example.com")

mail.to = "test@example.com"
mail.from = "from@example.com"
mail.subject = "例"
mail.body = "テストメールです。"

puts mail.encoded
