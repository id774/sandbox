# email.rb: Send a mail with the mail gem
#
# Description:
# Send a mail with the mail gem through a local SMTP server.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby email.rb
#
# Requirements:
# - Ruby
# - The mail gem
# - An SMTP server on localhost
#

require 'mail'

def sendmail
  hostname = `hostname`.chop
  return unless hostname.include?("id774.net")

  options = {
    :address  => "localhost",
    :port   => 25,
    :authentication => 'plain',
    :enable_starttls_auto => true
  }

  Mail.defaults do
    delivery_method :smtp, options
  end

  filename = "testmail.txt"
  dir = File.expand_path(File.dirname(__FILE__))
  path = File.join(dir, filename)

  mail = Mail.new do
    from     "774@#{hostname}"
    to       "774@id774.net"
    subject  "メール送信のテスト"
    body     "テストメールです"
    add_file :filename => filename, :content => File.read(path)
  end

  mail.charset = 'utf-8'
  mail.delivery_method :sendmail
  mail.deliver!
end

if __FILE__ == $0
  sendmail
end
