# -*- coding: utf-8-*-
import sys

import Image

import ImageDraw

import ImageFont

#import _imaging

#txt = '你好,世界!'
txt = u'א'
#font = ImageFont.truetype('/usr/share/fonts/truetype/fonts-japanese-gothic.ttf',24)
font = ImageFont.truetype('/usr/share/fonts/truetype/carmelitregular.ttf',24)
font = ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSansCondensed.ttf',24)
#size=(40,40)
size=font.getsize(txt)
if size[0]>size[1]:
	size=(size[0]/2,size[1])

im = Image.new("RGBA",size,(0,0,0))
print(size)
print(type(size))
#im = Image.new("RGBA",size,(0,0,0))

draw = ImageDraw.Draw(im)

#draw.text( (0,50), u'你好,世界!', font=font)

draw.text( (0,0), txt,font=font)
im.show()
#im.save("letters/test1.png")
