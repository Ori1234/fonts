# -*- coding: utf-8-*-
import sys

import Image

import ImageDraw

import ImageFont

#import _imaging

#txt = '你好,世界!'
txt = '界'

font = ImageFont.truetype('/usr/share/fonts/truetype/fonts-japanese-gothic.ttf',24)

im = Image.new("RGBA",(300,200),(0,0,0))

draw = ImageDraw.Draw(im)

#draw.text( (0,50), u'你好,世界!', font=font)

draw.text( (0,50), unicode(txt,'UTF-8'), font=font)
im.save("letters/test.png")
