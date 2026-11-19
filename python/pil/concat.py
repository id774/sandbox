# concat.py: Paste two images onto one canvas
#
# Description:
# Paste a.jpg and b.jpg from the current directory onto one canvas and save
# the result.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 concat.py
#
# Requirements:
# - Python 3
# - Pillow
#

from PIL import Image

a_jpg = Image.open('a.jpg', 'r')
b_jpg = Image.open('b.jpg', 'r')

canvas = Image.new('RGB', (100, 200), (255, 255, 255))

canvas.paste(a_jpg, (0, 0))
canvas.paste(b_jpg, (0, 100))

canvas.save('c.jpg', 'JPEG', quality=100, optimize=True)
