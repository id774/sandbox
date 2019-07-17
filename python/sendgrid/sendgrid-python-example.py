import sendgrid

api_key="YOUR_API_KEY"

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
