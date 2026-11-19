#!/usr/bin/env python
# secure_xmlrpc_client.py: XML-RPC calls over HTTPS
#
# Description:
# Call an XML-RPC server over HTTPS; the last call is unclosed and will not
# parse. The server is secure_xmlrpc_server.py.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Requirements:
# - Python 2, which provides xmlrpclib
#

import xmlrpclib

server = xmlrpclib.Server('https://127.0.0.1:443')
print(server.add(1, 2))
print(server.div(10, 4)
