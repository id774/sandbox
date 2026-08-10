# Shrink an image to fit within 1024 pixels.

from PIL import Image

img = Image.open('1.png', 'r')
img.thumbnail((1024, 1024))
img.save('2.png')
