import sys
from list_shift import List

def main(args_arr):
    args = List(args_arr)
    args.shift()

    args2 = args.shift()
    args3 = args.shift()
    args4 = args.shift()
    args5 = args.shift()

    print(args2)
    print(args3)
    print(args4)
    print(args5)

if __name__ == '__main__':
    argsmin = 0
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
