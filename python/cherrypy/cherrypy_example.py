# Serve a greeting with CherryPy quickstart.

import cherrypy
class HelloWorld(object):
    def index(self):
        return "Hello World!"
    index.exposed = True

cherrypy.quickstart(HelloWorld())
