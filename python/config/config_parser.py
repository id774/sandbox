#!/usr/bin/python
# -*- coding: utf-8 -*-

# Config File Example
# [My Settings]
# count = 0

# Execute
# python config_parser.py example.cfg "My Settings"

import configparser
import sys

def main(args):
    config_file = args[1]
    target_section = args[2]

    default_config = {
        'count': '0'
    }

    try:
        config = configparser.SafeConfigParser(default_config)
        config.read(config_file)
        count = config.getint(target_section, 'count') + 1
    except Exception as e:
        print('Error: Could not read config file: %s' % e, file=sys.stderr)
        return 1

    print('count = %s' % count)

    if not config.has_section(target_section):
        config.add_section(target_section)

    try:
        config.set(target_section, 'count', str(count))
        config.write(open(config_file, 'w'))
    except Exception as e:
        print('Error: Could not write to config file: %s' % e, file=sys.stderr)
        return 1

    return 0

if __name__ == '__main__':
    argsmin = 2
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
