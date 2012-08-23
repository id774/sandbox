# -*- coding: utf-8 -*-

import os, sys
from PIL import Image,ImageDraw,ImageFont

# フォントの指定
font=ImageFont.truetype('/usr/share/fonts/truetype/vlgothic/VL-Gothic-Regular.ttf',10,encoding='unic')

# RGB, 200x200 サイズ, 白い背景の画像を描画
img=Image.new('RGB',(200,200),(255,255,255))
draw=ImageDraw.Draw(img)

draw.line((20,50,150,80),fill=(255,0,0)) # 赤い直線を引く
draw.line((150,150,20,200),fill=(0,255,0)) # 緑の直線を引く
draw.text((40,80),'Hello Python!',(0,0,0)) # 黒い文字を書く
draw.text((25,45),u'テスト',font=font,fill='#000000') # 全角文字を出力

img.save('sample.jpg','JPEG') # JPEG として保存
