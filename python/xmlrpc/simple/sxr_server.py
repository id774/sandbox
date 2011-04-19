#!/usr/bin/env python

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

def main():
    import SimpleXMLRPCServer
    running = True
    def finis( ):
        global running
        running = False
        return 1
    server = SimpleXMLRPCServer.SimpleXMLRPCServer(("127.0.0.1", 3000))
    server.register_instance(StringFunctions( ), allow_dotted_names = True)
    server.register_function(lambda astr: '_' + astr, '_string')
    server.register_function(finis)
    while running:
        server.handle_request( )

if __name__ == '__main__':
    main()

