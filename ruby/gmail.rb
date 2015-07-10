
# http://grottad.com/blog/228

require 'gmail'

gmail = Gmail.connect("Gmail Address", "password")
gmail.deliver do
  to "送信先アドレス"
  subject "件名"
  text_part do
    body "本文"
  end
end
gmail.logout
