a = u"אריאל" #like this
#a = unicode("אריאל", "UTF-8") #or like this
font = ImageFont.truetype('simsun.ttc',24)
im=Image.new('RGB',(200,200),(100,100,100)) #type file,size,Background color

d=ImageDraw.Draw(im)
d.text( (0,0), a, font=font)
im.show()
