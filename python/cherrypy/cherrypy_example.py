# cherrypy_example.py: Greeting served with CherryPy quickstart
#
# Description:
# Serve a greeting with CherryPy quickstart.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 cherrypy_example.py
#
# Requirements:
# - Python 3
# - CherryPy
#

import cherrypy
class HelloWorld(object):
    def index(self):
        return "Hello World!"
    index.exposed = True

cherrypy.quickstart(HelloWorld())
