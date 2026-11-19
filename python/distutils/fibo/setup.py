# setup.py: Package the fibo module with distutils
#
# Description:
# Package the fibo module with distutils.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 setup.py install
#
# Requirements:
# - Python 3.11 or earlier, which still provides distutils
#

from distutils.core import setup

setup(name='fibo',
      version='1.0',
      description='Fibonacci Number',
      author='id774',
      author_email='774@id774.net',
      url='http://id774.net/',
      packages=['fibo'],)
