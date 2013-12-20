#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import requests
from requests.auth import HTTPBasicAuth

url       = 'http://157.7.155.117/post'
auth      = HTTPBasicAuth("your_username", "your_password")
headers   = {'content-type': 'application/json'}

json_data = {"test":"test"}
tag       = "debug.forward"

data      = json.dumps(json_data)
param     = {'tag':tag, 'data':data}
r = requests.post(url, params=param, headers=headers, auth=auth)
