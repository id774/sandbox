# -*- coding: utf-8 -*-

import os
import sys
from PIL import Image, ImageDraw

size = 128, 128

for infile in sys.argv[1:]:
    outfile = os.path.splitext(infile)[0] + ".thumbnail.jpg"
    if infile != outfile:
        try:
            im = Image.open(infile)
            im.thumbnail(size)
            im.save(outfile, "JPEG")
        except IOError:
            print "cannot create thumbnail for", infile
