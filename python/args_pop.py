import sys
import datetime

def args_pop(args):
    try:
        result = args.pop(1)
    except IndexError:
        result = None
    return (args, result)

def main(args):
    args, yyyymmdd = args_pop(args)
    if not yyyymmdd:
        d = datetime.date.today() - datetime.timedelta(days=1)
        yyyymmdd = d.strftime('%Y%m%d')

    args, option = args_pop(args)
    args, option2 = args_pop(args)

    print(yyyymmdd)
    print(option)
    print(option2)

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
