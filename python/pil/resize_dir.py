import sys
import os
from PIL import Image

def resize_file(size, filename, outpath):
    img = Image.open(filename, 'r')
    img.thumbnail((size, size))
    img.save(outpath)

def read_dir(size, src, out):
    for root, dirs, files in os.walk(src):
        for filename in files:
            if filename.endswith("png"):
                fullname = os.path.join(root, filename)
                outpath = os.path.join(out, filename)
                print("Resize: " + filename)
                resize_file(size, fullname, outpath)

def main(args):
    size = int(args[1])
    src = args[2]
    out = args[3]
    read_dir(size, src, out)

if __name__ == '__main__':
    argsmin = 3
    version = (3, 0)
    if sys.version_info > (version):
        if len(sys.argv) > argsmin:
            sys.exit(main(sys.argv))
        else:
            print("This program needs at least %(argsmin)s arguments" %
                  locals())
    else:
        print("This program requires python > %(version)s" % locals())
