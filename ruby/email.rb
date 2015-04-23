require 'mail'

def sendmail
  options = {
    :address  => "localhost",
    :port   => 25,
    :authentication => 'plain',
    :enable_starttls_auto => true
  }

  Mail.defaults do
    delivery_method :smtp, options
  end

  filename = "email.rb"
  dir = File.expand_path(File.dirname(__FILE__))
  path = File.join(dir, filename)

  mail = Mail.new do
    from     "774@id774.net"
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
