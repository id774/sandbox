#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Post a JSON payload to an API with basic authentication.

import json
import requests
from requests.auth import HTTPBasicAuth

url = 'http://example.com/post'
auth = HTTPBasicAuth("YOUR_USER", "YOUR_PASSWORD")
headers = {'content-type': 'application/json', 'content-length': '0'}

json_data = {"aaa": "bbb"}
tag = "debug.forward"

data = json.dumps(json_data)
param = {'tag': tag, 'data': data}
r = requests.post(url, params=param, headers=headers, auth=auth)
