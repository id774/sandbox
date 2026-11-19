# -*- coding: utf-8 -*-
# identify_image.py: Print the format, size, and mode of images
#
# Description:
# Print the format, size, and mode of each image given on the command line.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 identify_image.py <image>...
#
# Requirements:
# - Python 3
# - Pillow
#

import sys
from PIL import Image
from PIL import ImageDraw

for infile in sys.argv[1:]:
    try:
        im = Image.open(infile)
        print(infile, im.format, "%dx%d" % im.size, im.mode)
    except IOError:
        pass
