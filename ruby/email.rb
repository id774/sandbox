require 'mail'

options = { 
  :address  => "localhost",
  :port   => 25,
  :authentication => 'plain',
  :enable_starttls_auto => true  
}

Mail.defaults do
  delivery_method :smtp, options
end

file_path = "email.rb"

mail = Mail.new do
  from     "774@id774.net"
  to       "774@id774.net"
  subject  "メール送信のテスト"
  body     "テストメールです"
  add_file :filename => file_path, :content => File.read(file_path)
end

mail.charset = 'utf-8'
mail.delivery_method :sendmail
mail.deliver!
