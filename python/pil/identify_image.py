# -*- coding: utf-8 -*-

import os
import sys
from PIL import Image, ImageDraw

for infile in sys.argv[1:]:
    try:
        im = Image.open(infile)
        print infile, im.format, "%dx%d" % im.size, im.mode
    except IOError:
        pass
