#!/usr/bin/env python

import SimpleXMLRPCServer

class StringFunctions(object):
    def __init__(self):
        import string
        self.python_string = string
    def _privateFunction(self):
        return "Never get this on the client"
    def chop_in_half(self, astr):
        return astr[:len(astr)/2]
    def repeat(self, astr, times):
        return astr * times

if __name__ = '__main__':
    server = SimpleXMLRPCServer.SimpleXMLRPCServer(("localhost", 3000))
    server.register_instance(StringFunctions( ), allow_dotted_names = True)
    server.register_function(lambda astr: '_' + astr, '_string')
    server.serve_forever()

