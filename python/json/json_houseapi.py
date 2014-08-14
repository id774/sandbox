#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import requests
from requests.auth import HTTPBasicAuth

url = 'http://157.7.155.117/post'
auth = HTTPBasicAuth("houseapi", "kogaidan")
headers = {'content-type': 'application/json', 'content-length': '0'}

json_data = {"aaa": "bbb"}
tag = "debug.forward"

data = json.dumps(json_data)
param = {'tag': tag, 'data': data}
r = requests.post(url, params=param, headers=headers, auth=auth)
