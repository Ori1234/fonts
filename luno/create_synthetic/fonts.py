# -*- coding: utf-8-*-
import os
import Image
import ImageDraw
import ImageFont


letters=['א','ב','ג','ד','ה','ו','ז','ח','ט','י','כ','ך','ל','מ','ם','נ','ן','ס','ע','פ','ף','צ','ץ','ק','ר','ש','ת']
#letters=list('abcdefghijklmnop')
letters_folder="letters"

path='/usr/share/fonts/hebrew'
fonts=[]
for dirpath,dirnames,filenames in os.walk(path):
	for filename in [f for f in filenames if f.endswith(".ttf")]:
		fontPath=os.path.join(dirpath,filename)
		fonts.append(fontPath)


if not os.path.exists(letters_folder):
	os.makedirs(letters_folder)

for fontPath in fonts:
	fontName=fontPath.split('/')[-1][:-4]
	font=ImageFont.truetype(fontPath,20)
#	for l in letters:
	l='א'
	#print(l)
	img=Image.new("RGBA",(32,32),"white")
	draw=ImageDraw.Draw(img)
	draw.text((5,5),unicode(l,'UTF-8'),"black",font=font)
	#img.save(letters_folder+"/"+str(ord(l))+"_"+fontName+".png")
	img.save(letters_folder+"/"+'alef'+"_"+fontName+".png")

