#!/usr/bin/env python
# sxr_clent.py: Call string methods on a simple XML-RPC server
#
# Description:
# Call string methods on the XML-RPC server in sxr_server.py at
# 127.0.0.1:3000.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python sxr_clent.py
#
# Requirements:
# - Python 2, which provides xmlrpclib
# - sxr_server.py running on the same host
#

def main():
    import xmlrpclib
    server = xmlrpclib.Server('http://127.0.0.1:3000')
    print(server.chop_in_half('I am a confident guy'))
    print(server.repeat('Repetition is the key to learning!\n', 5))
    print(server._string('<= underscore'))
    # print(server._privateFunction())

if __name__ == '__main__':
    main()
