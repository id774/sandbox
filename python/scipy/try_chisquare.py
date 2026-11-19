# -*- coding: utf-8 -*-
# try_chisquare.py: Apply the chisquare helper to a contingency table
#
# Description:
# Run the chisquare helper on a contingency table and report significance.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 try_chisquare.py
#
# Requirements:
# - Python 3
# - SciPy from a release whose top-level namespace still provides NumPy
#   aliases such as scipy.array
#

import chisquare
import scipy as sp

array = sp.array([[435, 165],
                  [265, 135]])
ch2, p = chisquare.chisquare_test(array)

print("カイ二乗値は %(ch2)s" % locals())
print("確率は %(p)s" % locals())

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")
