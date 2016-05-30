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
