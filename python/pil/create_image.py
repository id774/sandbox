# -*- coding: utf-8 -*-
# Convert the images named on the command line to JPEG.

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
