math.randomseed(os.time())
letters={
	'alef',
	'bet',
	'gimel',
	'dalet',
	'he',
	'vav',
	'zain',
	'khet',
	'tet',
	'yod',
	'kaf',
	'lamed',
	'mem',
	'nun',
	'samekh',
	'ayin',
	'pe',
	'tsade',
	'qof',
	'resh',
	'shin',
	'tav'
}

local F1_path='DATA/4Q250/'
local F2_path='DATA/4Q324/'


import 'image'
F1={}
F2={}
for i=1,#letters do
	l=letters[i]
	F1[l]={}
	for f in io.popen("ls  "..F1_path..l.."*"):lines() do
		table.insert(F1[l],f)
	end
	F2[l]={}
	for f in io.popen("ls  "..F2_path..l.."*"):lines() do
		table.insert(F2[l],f)
	end
end
local folder1
local folder2

--do return end

local num_of_test=1000
--num_of_test=50
inputs={}
labels={}
orig_inputs={}
for i = 1, num_of_test do
--   TODO 1) put here my data by 
--           1.0) choose letter x
	local same=(math.random(1, 10) > 5)
	local l=letters[math.random(#letters)]
	--print(l)
	while #F1[l]==0 or #F2[l]==0 do
		l=letters[math.random(#letters)]
	end
	--           1.1) random same/not same font
	if not same then
		folder1=F1
		folder2=F2
		if (math.random(1,10)>5) then
			folder1=F2
			folder2=F1
		end
	else
		folder1=F1
		if (math.random(1,10)>5) then
			folder1=F2		     	
		end
		folder2=folder1
	end

while same and #folder1[l]<2 do	
	l=letters[math.random(#letters)]
end

im_path1=folder1[l][math.random(#folder1[l])]

im_path2=folder2[l][math.random(#folder2[l])]

while im_path1==im_path2 do
	im_path2=folder2[l][math.random(#folder2[l])]
end
--print(im_path2)	
--print(im_path1)
im1=image.load(im_path1)
im2=image.load(im_path2)
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

--do return end
require 'cudnn'
require 'cunn'
local model=torch.load('snapshot/snapshot_epoch_50.net')

local model1=model:double()
local model2=model:cuda()

results={}
for i=1,#orig_inputs do
	--local dist=model1:forward(orig_inputs[i])
	local dist=model2:forward(orig_inputs[i]:cuda())
	table.insert(results,-dist[1])
	lab=labels[i]==1 and 1 or 0
--	print(string.format("%.0f, %.7f", labels[i],dist[1]))
--	print(dist)
end

metrics = require 'metrics'


roc_points, thresholds = metrics.roc.points(torch.DoubleTensor(results), torch.IntTensor(labels))
area = metrics.roc.area(roc_points)

print(area)

--gfx.chart(roc_points)

require 'gnuplot'
gnuplot.plot(roc_points)




