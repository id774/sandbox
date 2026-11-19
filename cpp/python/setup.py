# setup.py: Build the myupper C++ extension with distutils
#
# Description:
# Build myupper.cpp as the myupper Python extension module with distutils.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 setup.py build_ext --inplace
#
# Requirements:
# - Python 3.11 or earlier, which still provides distutils
# - Python development headers and a C++ compiler
#

from distutils.core import setup, Extension
module = Extension('myupper', ['myupper.cpp'])
setup(name='myupper',
      version='1.0',
      ext_modules=[module],
     )
