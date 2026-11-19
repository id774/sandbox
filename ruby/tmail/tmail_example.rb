#! /opt/ruby/1.8.7/bin/ruby
# -*- coding: utf-8 -*-
# tmail_example.rb: Compose a mail with TMail
#
# Description:
# Compose a mail with TMail.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby tmail_example.rb
#
# Requirements:
# - Ruby 1.8.7, as the shebang suggests
# - The tmail gem
#

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
