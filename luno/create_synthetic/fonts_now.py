# -*- coding: utf-8-*-
import os
import Image
import ImageDraw
import ImageFont
from random import randint
import ImageFilter
letters=[u'א',u'ב',u'ג',u'ד',u'ה',u'ו',u'ז',u'ח',u'ט',u'י',u'כ',u'ך',u'ל',u'מ',u'ם',u'נ',u'ן',u'ס',u'ע',u'פ',u'ף',u'צ',u'ץ',u'ק',u'ר',u'ש',u'ת']
#letters=list('abcdefghijklmnopABCDEFGHIJKLMNOPQRSTUVWXYZ')
letters_folder="letters_now25"

#path='/usr/share/fonts/hebrew'
fonts=[]
#for dirpath,dirnames,filenames in os.walk(path):
#	for filename in [f for f in filenames if f.endswith(".ttf")]:
#		fontPath=os.path.join(dirpath,filename)
#		fonts.append(fontPath)

list_fonts='hebrew_fonts.txt'
file = open(list_fonts, 'r')
for fontPath in file:
	if fontPath.lower().endswith(".ttf"):
		print(fontPath)
	else:
#		print(fontPath)
		fonts.append(fontPath.rstrip('\n'))

if not os.path.exists(letters_folder):
	os.makedirs(letters_folder)

for fontPath1 in fonts:
	
	print(fontPath1)	
	fontPath=fontPath1.strip().strip(':')
	print(fontPath)	
	fontName=fontPath.split('/')[-1][:-5]
	print(fontName)
	font=ImageFont.truetype(fontPath,40)
	for l in letters:
	#l='א'
	#print(l)
		#TODO add borders to the image
		border=5
		size=font.getsize(l)
#		if size[0]>size[1]*1.5:
		

		size=(size[0]+2*border,size[1]+2*border)
#		size=(size[1],size[0])
		offset=font.getoffset(l)
		offset=(-offset[0]/2+border,-offset[1]/2+border)
		#offset=(0,0)
		print(size)
		img=Image.new("RGBA",size,"white")
		#img=Image.new("RGBA",(32,32),"white")
		draw=ImageDraw.Draw(img)
		#draw.text((0,0),l,"white",font=font)
		draw.text(offset,l,"black",font=font)
		#img.save(letters_folder+"/"+str(ord(l))+"_"+fontName+".png")
		for i in range(1,200): #Draw random points
			draw.point((randint(0,size[0]),randint(0,size[1])),fill=0)
		#blur
		img=img.filter(ImageFilter.GaussianBlur(radius=1))

		img.save(letters_folder+"/"+str(ord(l))+"_"+fontName+".png")
#		img.save(letters_folder+"/"+l+"_"+fontName+str(offset)+str(size)+".png")

