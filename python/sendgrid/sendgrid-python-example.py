# sendgrid-python-example.py: Send mail through the SendGrid API
#
# Description:
# Send mail through the SendGrid API with a key taken from the
# SENDGRID_API_KEY environment variable.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     SENDGRID_API_KEY=<key> python3 sendgrid-python-example.py
#
# Requirements:
# - Python 3
# - The sendgrid package
# - A SendGrid API key and network access to the SendGrid API
#

import sendgrid
import os

api_key = os.environ["SENDGRID_APIKEY"]

sg = sendgrid.SendGridAPIClient(api_key)
data = {
  "personalizations": [
    {
      "to": [
        {
          "email": "774@id774.net"
        }
      ],
      "subject": "テストです"
    }
  ],
  "from": {
    "email": "774@id774.net"
  },
  "content": [
    {
      "type": "text/plain",
      "value": "テストメールの送信です"
    }
  ]
}
response = sg.client.mail.send.post(request_body=data)

print(response.status_code)
print(response.body)
print(response.headers)
