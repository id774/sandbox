# -*- coding: utf-8 -*-
# create_image.py: Convert images to JPEG
#
# Description:
# Convert the images named on the command line to JPEG.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 create_image.py <image>...
#
# Requirements:
# - Python 3
# - Pillow
#

import os
import sys
from PIL import Image
from PIL import ImageDraw

for infile in sys.argv[1:]:
    f, e = os.path.splitext(infile)
    outfile = f + ".jpg"
    if infile != outfile:
        try:
            Image.open(infile).save(outfile)
        except IOError:
            print("cannot convert", infile)
