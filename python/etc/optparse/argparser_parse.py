from argparse import ArgumentParser

def parser():
    usage = 'Usage: python {} FILE [--verbose] [--cat <file>] [--help]'\
            .format(__file__)
    argparser = ArgumentParser(usage=usage)
    argparser.add_argument('fname', type=str,
                           help='echo fname')
    argparser.add_argument('-v', '--verbose',
                           action='store_true',
                           help='show verbose message')
    argparser.add_argument('-c', '--cat', type=str,
                           dest='another_file',
                           help='concatnate target file name')
    args = argparser.parse_args()
    if args.verbose:
        return 'your input is {}!!!'.format(args.fname)
    if args.another_file:
        return 'concatenated: {}{}'.format(args.fname, args.another_file)
    return 'input is {}'.format(args.fname)

if __name__ == '__main__':
    result = parser()
    print(result)
