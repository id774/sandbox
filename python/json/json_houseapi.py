#!/usr/bin/env python
# -*- coding: utf-8 -*-
# json_houseapi.py: Post a JSON payload with basic authentication
#
# Description:
# Post a JSON payload to an API with basic authentication.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 json_houseapi.py
#
# Requirements:
# - Python 3
# - Requests
# - Network access to the API endpoint in the source
#

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
