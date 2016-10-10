# -*- coding: utf-8-*-
import ImageFont, ImageDraw, Image

#image = Image.open('hsvwheel.png')
image=Image.new("RGBA",(50,50),"black")
draw = ImageDraw.Draw(image)
txt = "א"
fontsize = 1  # starting font size

# portion of image width you want text width to be
img_fraction =1 

font = ImageFont.truetype("arial.ttf", fontsize)
while font.getsize(txt)[0] < img_fraction*image.size[0]:
    # iterate until the text size is just larger than the criteria
    fontsize += 1
    font = ImageFont.truetype("arial.ttf", fontsize)

# optionally de-increment to be sure it is less than criteria
fontsize -= 1
font = ImageFont.truetype("arial.ttf", fontsize)

print 'final font size',fontsize
draw.text((0, 0),unicode( txt,'UTF-8'), font=font) # put the text on the image
image.show()
