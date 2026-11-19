# image_resize.py: Shrink an image to fit within 1024 pixels
#
# Description:
# Shrink 1.png from the current directory to fit within 1024 pixels.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 image_resize.py
#
# Requirements:
# - Python 3
# - Pillow
#

from PIL import Image

img = Image.open('1.png', 'r')
img.thumbnail((1024, 1024))
img.save('2.png')
