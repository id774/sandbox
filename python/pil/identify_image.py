# -*- coding: utf-8 -*-
# Print the format, size, and mode of each image given on the command line.

import sys
from PIL import Image
from PIL import ImageDraw

for infile in sys.argv[1:]:
    try:
        im = Image.open(infile)
        print(infile, im.format, "%dx%d" % im.size, im.mode)
    except IOError:
        pass
