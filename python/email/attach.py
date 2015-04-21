import smtplib

from email import encoders
from email.utils import formatdate
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

def create_message(from_addr, to_addr, subject, body, mime, attach_file):
    msg = MIMEMultipart()
    msg["Subject"] = subject
    msg["From"] = from_addr
    msg["To"] = to_addr
    msg["Date"] = formatdate()

    body = MIMEText(body)
    msg.attach(body)

    attachment = MIMEBase(mime['type'], mime['subtype'])
    file = open(attach_file['path'])
    attachment.set_payload(file.read())
    file.close()
    encoders.encode_base64(attachment)
    msg.attach(attachment)
    attachment.add_header(
        "Content-Disposition", "attachment", filename=attach_file['name'])

    return msg

def send(from_addr, to_addrs, msg):
    smtp = smtplib.SMTP("localhost")
    smtp.sendmail(from_addr, to_addrs, msg.as_string())
    smtp.close()

if __name__ == '__main__':
    to_addr = '774@id774.net'
    from_addr = '774@id774.net'
    subject = "メール送信のテスト (添付有り)"
    body = "テストメールです"
    mime = {'type': 'text', 'subtype': 'comma-separated-values'}
    attach_file = {'name': 'test.csv', 'path': './test.csv'}
    msg = create_message(from_addr, to_addr, subject, body, mime, attach_file)
    send(from_addr, [to_addr], msg)
