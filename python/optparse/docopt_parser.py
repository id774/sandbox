# docopt_parser.py: Command line options from a docopt docstring
#
# Description:
# Parse command line options from the module docstring with docopt.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 docopt_parser.py <fname> [-v | --verbose] [-c | --cat <another_file>]
#
# Requirements:
# - Python 3
# - docopt
#

__doc__ = """{f}

Usage:
    {f} <fname> [-v | --verbose] [-c | --cat <another_file>]
    {f} -h | --help

Options:
    -c --cat <ANOTHER_FILE>  concatnate target file name
    -v --verbose             Show verbose message
    -h --help                Show this screen and exit.
""".format(f=__file__)

from docopt import docopt


def parse():
    args = docopt(__doc__)
    if args['--verbose']:
        return 'your input is {}!!!'.format(args['<fname>'])
    if args['--cat']:
        return 'concatenated: {}{}'.format(args['<fname>'],
                                           args['--cat'][0])
    return 'input is {}'.format(args['<fname>'])


if __name__ == '__main__':
    result = parse()
    print(result)
