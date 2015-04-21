import smtplib
from email.mime.text import MIMEText
from email.header import Header

con = smtplib.SMTP('localhost')
con.set_debuglevel(True)

cset = 'utf-8'

title = 'メール送信テスト'
msg = 'メール送信のテストです'
message = MIMEText(msg, 'plain', cset)
message['Subject'] = Header(title, cset)
message['From'] = '774@id774.net'
message['To'] = '774@id774.net'

con.sendmail(message['From'], [message['To']],
             message.as_string())

con.close()
