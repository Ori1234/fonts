local F1
local F2

--returns a table that contains a list of images path for each letter 1488 to 1514 that are found in [dir]
function preper_data_syntetic(dir)
	F1={}
	for letter=1488,1514 do
		F1[letter]={}
		for f in io.popen("ls "..dir.."/"..letter.."*.png"):lines() do
			table.insert(F1[letter],f)
		end
	end
----	print(F1)
	return F1
end



--slice table
function slice(tbl, first, last, step)
	local sliced = {}
	for i = first or 1, last or #tbl, step or 1 do
		sliced[#sliced+1] = tbl[i]
	end
	return sliced
end


letters={
 'alef','bet', 'gimel', 'dalet', 'he', 'vav', 'zain', 'khet', 'tet', 'yod', 'kaf', 'lamed', 'mem', 'nun', 'samekh', 'ayin', 'pe', 'tsade', 'qof', 'resh', 'shin','tav'
}


function preper_data_real(F1_path,F2_path)
F1={}
F2={}
print('\nERRORS HERE INDICATE THAT THERE"S NO TEST SAMPLES FOR THIS LETTER IN THE FOLDER: ')
for i=1,#letters do
        l=letters[i]
        F1[l]={}
	ite= io.popen("ls  "..F1_path..l.."*")
        for f in iter:lines()do
                table.insert(F1[l],f)
        end
        F2[l]={}
        for f in io.popen("ls  "..F2_path..l.."*"):lines() do
                table.insert(F2[l],f)
        end
end
	return F1,F2
end



function pair_syntetic(letter,same)
	require 'my_utils.lua'	
	a=choose_random_font(letter)
        if not same then
        	b=choose_random_font(letter)
                while b==a do
			b=choose_random_font(letter)
                end
        else
                b=a
        end
        noise=1
                        --print(same)
                        --print('a:'..a)
                        --print('b:'..b..'\n')
                        --im1=im_transform(x..a,noise,0,{0,0})
	im1=im_transform(a,noise)
        im2=im_transform(b,noise)

        local input=torch.Tensor(2,1,im1:size(1),im1:size(2),im1:size(3))
        input[1]=im1
        input[2]=im2
        --TODO normalize over all data - need to prepare data in advance                
        local mean=input:mean()
        local std=input:std()
        input:add(-mean)
        input:mul(1.0/std)	
	return input
end

function choose_random_font(letter)
	--print(letter)
        return F1[letter][math.random(#F1[letter])]
end

--for syntetic test
function rand_staff(same)
 	local folder1
	local folder2

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
	return l,folder1,folder2
end

function pair_real(l,folder1,folder2)
	require 'image'
        im_path1=folder1[l][math.random(#folder1[l])]

        im_path2=folder2[l][math.random(#folder2[l])]

        while im_path1==im_path2 do
                im_path2=folder2[l][math.random(#folder2[l])]
        end
	
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
end



function choose_random_font_dep()  
        local font = font_list[math.random(#font_list)] 
        local bold='normal' 
        if math.random(1,10)>5 then
                bold='bold'
        end
        local italic='normal'
        if math.random(1,10)>5 then
                italic='italic'
        end
        local bold='normal' 
        if math.random(1,10)>5 then
                bold='bold'
        end
        local italic='normal'
        if math.random(1,10)>5 then
                italic='italic'
        end
        return font..'-'..bold..'-'..italic..'.png'
end






