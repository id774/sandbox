# -*- coding: utf-8 -*-
# create_thumbnails.py: Create 128 pixel thumbnails
#
# Description:
# Create a 128 pixel thumbnail for each image given on the command line.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 create_thumbnails.py <image>...
#
# Requirements:
# - Python 3
# - Pillow
#

import os
import sys
from PIL import Image
from PIL import ImageDraw

size = 128, 128

for infile in sys.argv[1:]:
    outfile = os.path.splitext(infile)[0] + ".thumbnail.jpg"
    if infile != outfile:
        try:
            im = Image.open(infile)
            im.thumbnail(size)
            im.save(outfile, "JPEG")
        except IOError:
            print("cannot create thumbnail for", infile)
