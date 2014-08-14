#!/usr/bin/env python
# -*- coding: utf-8 -*-

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
