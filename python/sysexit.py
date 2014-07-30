import sys

def main(args):
    print("arg1 is %s" % args[1])
    return 1 # This program always return code 1.

if __name__ == '__main__':
    argsmin = 1
    version = (3,0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %locals())
    else:
        print("This program requires python > %(version)s" %locals())

