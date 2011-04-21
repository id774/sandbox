#!/usr/bin/env python

import xmlrpclib

server = xmlrpclib.Server('https://127.0.0.1:443')
print server.add(1,2)
print server.div(10,4)
