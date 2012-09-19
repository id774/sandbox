#!/usr/bin/env python

import sys, os

class PythonModuleVersion:
    def __init__(self):
        pass

    def python_version(self):
        try:
            import sys
            return 'Python', sys.version_info
        except ImportError:
            return 'Python ImportError'

    def nose_version(self):
        try:
            import nose
            return 'nose', nose.__version__
        except ImportError:
            return 'nose ImportError'

    def sqlalchemy_version(self):
        try:
            import sqlalchemy
            return 'SQLAlchemy', sqlalchemy.__version__
        except ImportError:
            return 'SQLAlchemy ImportError'

    def ipython_version(self):
        try:
            import IPython
            return 'ipython', IPython.__version__
        except ImportError:
            return 'ipython ImportError'

    def nltk_version(self):
        try:
            import nltk
            return 'nltk', nltk.__version__
        except ImportError:
            return 'nltk ImportError'

    def MeCab_version(self):
        try:
            import MeCab
            return 'MeCab', MeCab.VERSION
        except ImportError:
            return 'MeCab ImportError'

def show_version():
    import pkg_resources
    m = PythonModuleVersion()
    print(m.python_version())
    print(m.nose_version())
    print(m.sqlalchemy_version())
    print(m.ipython_version())
    print(m.nltk_version())
    print(m.MeCab_version())

def module_install():
    import os
    os.system('sudo easy_install nose')
    os.system('sudo easy_install -Z SQLAlchemy')
    os.system('sudo easy_install IPython')
    os.system('sudo easy_install -U distribute')
    os.system('sudo easy_install pip')
    os.system('sudo pip install -U numpy')
    os.system('sudo pip install -U pyyaml nltk')

def main():
    from optparse import OptionParser
    usage = "usage: %prog [options]"
    parser = OptionParser(usage)
    parser.add_option("-i", "--install", help="module install",
                      action="store_true", dest="install")
    (options, args) = parser.parse_args()
    if options.install:
        module_install()
    else:
        show_version()

if __name__=='__main__':
    main()

