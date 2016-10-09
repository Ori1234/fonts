font_list={'Aharoni_CLM',
'David_CLM',
'Droid_Sans_Hebrew',
'Ellinia_CLM',
'Ezra_SIL_SR',
'Frank_Ruehl_CLM',
'Hadasim_CLM',
'Keter_YG',
'Linux_Libertine_Initials_O',
'Miriam_CLM',
'Miriam_Mono_CLM',
'Shofar',
'Simple_CLM',
'Stam_Ashkenaz_CLM',
'Stam_Sefarad_CLM',
'Yehuda_CLM'
}
require 'my_utils.lua'

inputs={}
labels={}
orig_inputs={}
for i = 1, 50 do
             x='_1488-'
--           1.1) random same/not same font
              same=(math.random(1, 10) > 5)
---              1.1.1) choose font/2 fonts randomly a (and b) in random from font_list
              a = font_list[math.random(#font_list)]
              bold='normal' --TODO rsandom
             if math.random(1,10)>5 then
                bold='bold'
             end
             local italic='normal'
             if math.random(1,10)>5 then
                italic='italic'
             end
             a=a..'-'..bold..'-'..italic..'.png'
             if not same then
                     b= font_list[math.random(#font_list)]    --local?
                     while b==a do
                        b= font_list[math.random(#font_list)]    
                     end
                     local bold='normal'
                     if math.random(1,10)>5 then
                        bold='bold'
                     end
                     local italic='normal'
                     if math.random(1,10)>5 then
                        italic='italic'
                     end
                     b=b..'-'..bold..'-'..italic..'.png'
             else
                     b=a
             end
--           1.2) if same: call im1=im_transform(x_a,0),im2=im_transform(x_b,0) 
--                if not same: ...i
             noise=1
             --print(same)
             --print('a:'..x..a)
             --print('b:'..x..b..'\n')
             --im1=im_transform(x..a,noise,0,{0,0})
             im1=im_transform(x..a,noise);
             im2=im_transform(x..b,noise);
--        3) append x_a,x_b 
              input=torch.Tensor(2,im1:size(1),im1:size(2),im1:size(3))
--        3) run (almost probably need to change model sizes)   
             input[1]=im1
             input[2]=im2
              mean=input:mean()
              std=input:std()
             input:add(-mean)
             input:mul(1.0/std)
   	     label = same and 1 or -1
             table.insert(inputs, image.toDisplayTensor(input))
	     table.insert(orig_inputs,input)
   	     table.insert(labels, label)
end


images1=image.toDisplayTensor{input = inputs, padding=10,nrow=5}
image.save('data_example1.png',images1)



