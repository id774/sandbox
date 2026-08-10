# -*- coding: utf-8 -*-
# Draw text onto a generated image with a Japanese font.

import sys
from PIL import Image, ImageDraw, ImageFont

# Choose the font
if sys.platform == "darwin":
    font_path = "/Library/Fonts/Osaka.ttf"
else:
    font_path = "/usr/share/fonts/truetype/fonts-japanese-gothic.ttf"
font = ImageFont.truetype(font_path,
                          10, encoding='unic')

# Create a 200x200 RGB image on a white background
img = Image.new('RGB', (200, 200), (255, 255, 255))
draw = ImageDraw.Draw(img)

draw.line((20, 50, 150, 80), fill=(255, 0, 0))  # draw a red line
draw.line((150, 150, 20, 200), fill=(0, 255, 0))  # draw a green line
draw.text((40, 80), 'Hello Python!', (0, 0, 0))  # write black text
draw.text((25, 45), 'テスト', font=font, fill='#000000')  # write full width characters

img.save('sample.jpg', 'JPEG')  # save as JPEG
