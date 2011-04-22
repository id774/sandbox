#!/usr/bin/env python

def main():
    import xmlrpclib
    server = xmlrpclib.Server('http://127.0.0.1:3000')
    print(server.chop_in_half('I am a confident guy'))
    print(server.repeat('Repetition is the key to learning!\n', 5))
    print(server._string('<= underscore'))
    #print(server._privateFunction())

if __name__ == '__main__':
    main()

