# sendmail.rb: Mail with an attachment using the mail gem
#
# Description:
# Send a mail with an attachment using the mail gem.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby sendmail.rb
#
# Requirements:
# - Ruby
# - The mail gem
# - An SMTP server reachable by the mail gem
#

require "mail"

mail = Mail.new do
  from     "test@example.jp"
  to       "test@example.jp"
  subject  "subject text"
  body     File.read("body.txt")
  add_file "./console.log"
end

mail["Comments"] = "Some comments"

mail.smtp_envelope_from = "test@example.jp"
mail.smtp_envelope_to   = "test@example.jp"


mail.delivery_method(:smtp,
  address:        "mail.server.jp",
  port:           25,
  domain:         "example.jp",
  authentication: nil,
  user_name:      nil,
  password:       nil
)

mail.deliver
