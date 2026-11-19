# sendmail.py: Send a UTF-8 plain text mail through a local SMTP server
#
# Description:
# Send a UTF-8 plain text mail through a local SMTP server.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 sendmail.py
#
# Requirements:
# - Python 3
# - An SMTP server on localhost
#

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
