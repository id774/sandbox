# zip_and_loop.py: Iterate two lists in parallel with zip
#
# Description:
# Iterate two lists in parallel with zip.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 zip_and_loop.py
#
# Requirements:
# - Python 3
#

names = ['Taro', 'Hanako', 'Jiro']
colors = ['blue', 'red', 'yellow']

for name, color in zip(names, colors):
    print(name, '-->', color)
