#!/usr/bin/env python
# -*- coding: utf-8 -*-
# merge_df.py: Merge WiFi client and temperature readings
#
# Description:
# Merge WiFi client and temperature readings fetched as JSON on their index.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 merge_df.py
#
# Requirements:
# - Python 3
# - NumPy and pandas
# - Network access to the house-api-project.org JSON endpoints in the source
#

import sys
import numpy as np
import pandas as pd

wifi = pd.read_json(
    'http://house-api-project.org/api/shibuhouse/wifi/clients?limit=100house-api-project.org/api/shibuhouse/wifi/1f/clients?limit=100')
temp = pd.read_json(
    'http://house-api-project.org/api/shibuhouse/1f/temperature?limit=100')
print(wifi.head(20))
print(temp.head(20))

merged = pd.merge(wifi, temp, left_index=True, right_index=True)

print('merged')
print(merged.head(20))
