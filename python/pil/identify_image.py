# -*- coding: utf-8 -*-

import sys
from PIL import Image
from PIL import ImageDraw

for infile in sys.argv[1:]:
    try:
        im = Image.open(infile)
        print(infile, im.format, "%dx%d" % im.size, im.mode)
    except IOError:
        pass
