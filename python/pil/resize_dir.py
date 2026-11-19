# resize_dir.py: Resize every image in a directory
#
# Description:
# Resize every image file in a directory to a requested size.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 resize_dir.py <size> <source directory> <output directory>
#
# Requirements:
# - Python 3.12 or earlier, which still provides imghdr
# - Pillow
#

import os
import imghdr
import argparse
from PIL import Image

def resize_file(size, filename, outpath):
    img = Image.open(filename, 'r')
    img.thumbnail((size, size))
    img.save(outpath)

def is_image_file(filename):
    return imghdr.what(filename) in ['jpeg', 'png']

def read_dir(size, src, out):
    for root, _, files in os.walk(src):
        for filename in files:
            fullname = os.path.join(root, filename)
            if is_image_file(fullname):
                outpath = os.path.join(out, filename)
                print("Resize: {}".format(filename))
                resize_file(size, fullname, outpath)

def parse_args():
    parser = argparse.ArgumentParser(description="Resize images in a directory.")
    parser.add_argument("size", type=int, help="Size of the output image.")
    parser.add_argument("src", help="Source directory of images.")
    parser.add_argument("out", help="Output directory for resized images.")
    return parser.parse_args()

def main():
    args = parse_args()
    read_dir(args.size, args.src, args.out)

if __name__ == '__main__':
    main()

